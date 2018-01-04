require 'celluloid'

module Spree
  module Openpay
    class PaymentNotificationHandler
      include Celluloid

      attr_reader :params, :action, :order, :delay

      ACTIONS = Hash.new(:failure!).merge! 'charge.succeeded' => :capture!

      def initialize(params, delay = 60)
        @params = params
        @delay  = delay
        @action = ACTIONS[params['type']]
        @order  = params['transaction']['order_id'].split('-').first
      end

      def perform_action
        after(delay) do
          ActiveRecord::Base.connection_pool.with_connection do
            payment.try(action)
          end
        end
      end

      private

      def payment
        ActiveRecord::Base.connection_pool.with_connection do
          Spree::Payment.find_by_order_number(order)
        end
      end
    end
  end
end
