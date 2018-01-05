module Spree
   class BillingIntegration::OpenpayGateway < Gateway
     preference :auth_token, :string
     preference :source_method, :string, default: ['card, cash, bank']
     preference :openpay_id, :string

     unless Rails::VERSION::MAJOR == 4
       attr_accessible :preferred_auth_token, :preferred_source_method, :gateway_response, :preferred_openpay_id
     end

     def provider_class
       warn "DEPRECATION WARNING: Spree::BillingIntegration::Openpay will be deprecated, please use BillingIntegration::OpenpayGateway::#{preferred_source_method.titleize} instead"
       Spree::Openpay::Provider
     end

     def payment_source_class
       card? ? CreditCard : Spree::OpenpayPayment
     end

     def method_type
       card? ? 'gateway' : 'openpay'
     end

     def card?
       preferred_source_method.eql?('card')
     end

     def auto_capture?
       false
     end
   end
end
