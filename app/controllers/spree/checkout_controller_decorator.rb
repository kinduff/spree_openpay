module Spree
  CheckoutController.class_eval do
    before_action :add_device_session, only: :update
    
    if Rails::VERSION::MAJOR >= 4
      before_action :permit_installments_number
      before_action :permit_openpay_response
    end
    
    def add_device_session
      unless @order.completed?
        if params[:deviceIdHiddenFieldName].present?
          @order.update(:device_session_id=>params[:deviceIdHiddenFieldName])
        end  
      end
    end
    
    def completion_route
      if @order.payments.present? && openpay_payment?(@order.payments.last.payment_method)
         openpay_payment_path(@order)
      else
        spree.order_path(@order)
      end
    end

    private

    def openpay_payment?(payment_method)
        [Spree::BillingIntegration::OpenpayGateway::Bank, Spree::BillingIntegration::OpenpayGateway::Cash].include? payment_method.class
    end

    def permit_installments_number
      permitted_source_attributes << :installments_number
    end

    def permit_openpay_response
      permitted_source_attributes << :openpay_response
    end
  end
end
