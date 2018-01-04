module Spree::Openpay
  class Response < ActiveMerchant::Billing::Response
    attr_accessor :response, :source_method, :status, :charge_id

    def initialize(response, source_method)
      @success = !(response.eql?('null') || response.include?('category')) if response
      @message = @success ? 'Ok' : response['description']
      @params = response
      @params['description'] = @success ? 'Ok' : response['description']
      @status = response['status']
      @source_method = source_method
      @charge_id = (response.include?('transaction_type') && response['transaction_type'] == "charge") ? response['id'] : nil
    end
  end
end
