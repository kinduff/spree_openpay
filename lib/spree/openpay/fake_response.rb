module Spree::Openpay
  class FakeResponse < ActiveMerchant::Billing::Response

    def initialize
      @success = true
      @message = "Orden devuelta"
      @params = {}
    end
  end
end