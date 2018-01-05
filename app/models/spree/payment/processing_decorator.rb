Spree::Payment::Processing.class_eval do
    def handle_response(response, success_state, failure_state)
        record_response(response)
        
        if response.success?
          unless response.authorization.nil?
            self.response_code = response.authorization
            self.avs_response = response.avs_result['code']

            if response.cvv_result
              self.cvv_response_code = response.cvv_result['code']
              self.cvv_response_message = response.cvv_result['message']
            end
          end
          
          #Get the charge id from Openpay and save it in the order
          if (response.try(:charge_id) && !response.charge_id.nil?)
            #payment_order = self.order
            #payment_order.openpay_transaction_id = response.charge_id
            #payment_order.save
            self.response_code = response.charge_id
          end
          
          self.send("#{success_state}!")
        else
          self.send(failure_state)
          gateway_error(response)
        end
    end
end