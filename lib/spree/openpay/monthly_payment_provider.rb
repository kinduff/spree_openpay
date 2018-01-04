module Spree::Openpay
  class MonthlyPaymentProvider
    attr_accessor :auth_token

    attr_reader :options

    def initialize(options = {})
      @options       = options
      @auth_token    = options[:auth_token]
    end

    def authorize(amount, source, gateway_options = {})
      Response.new(parse_openpay_response(source.openpay_response), gateway_options)
    end

    def capture(amount, source, gateway_options = {})
      Response.new({}, gateway_options)
    end

    private

    def parse_openpay_response(response)
      Oj.load response || '{}'
    end
  end
end
