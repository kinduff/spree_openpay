module Spree::Openpay
  class Response < ActiveMerchant::Billing::Response
    attr_accessor :response, :source_method, :status

    def initialize(response, source_method)
      @success = !(response.eql?('null') || response.include?('category')) if response
      @message = @success ? 'Ok' : response['description']
      @params = response
      @params['description'] = @success ? 'Ok' : response['description']
      @status = response['status']
      @source_method = source_method
    end
  end
end
