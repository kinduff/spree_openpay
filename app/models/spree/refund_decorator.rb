module Spree
    Refund.class_eval do
        after_create :openpay_refund
        
        attr_accessor :openpay_api, :auth_token, :openpay_id, :end_point
     
        def openpay_refund
            puts "Tratando de llamar a Openpay Refund"
            
            payment = self.payment
            payment_method = payment.payment_method
            order_user = payment.order.user
            
            if payment_method.class != Spree::BillingIntegration::OpenpayGateway::Card
                puts "El Metodo de Pago es diferente a Tarjeta, reembolso no generado en Openpay"
                return
            end
            
            @openpay_api = payment_method.preferred_test_mode
            @auth_token = payment_method.preferred_auth_token
            @openpay_id = payment_method.preferred_openpay_id
            
            if order_user.nil? || !payment_method.preferred_use_wallet
                @end_point = "charges/#{payment.transaction_id}/refund"
            else
                @end_point = "customers/#{order_user.openpay_id}/charges/#{payment.transaction_id}/refund"
            end
            
            params = {
                "description" => "Refund for order #{payment.order.number}"
                #"amount" => self.amount.to_f
            }
            
            response = Oj.load connection.post(endpoint, Oj.dump(params)).body
                
            @success = !(response.eql?('null') || response.include?('category')) if response
                
            if @success
                puts "Todo bien en el refund"
            else    
                puts "Error en el refund"
                
                logger.error(Spree.t(:gateway_error) + "  #{response.to_yaml}")
                text = response['description']
                raise Core::GatewayError.new(text)
            end
        end
        
        def connection
            Faraday.new(url: openpay_url + merchant_id + "/") do |faraday|
                faraday.request :url_encoded

                faraday.headers = headers
                faraday.adapter :typhoeus
                faraday.basic_auth(auth_token, nil)
            end
        end

        def openpay_url
            if @openpay_api
                "https://sandbox-api.openpay.mx/v1/"
            else
                "https://dev-api.openpay.mx/v1/"
            end
        end
        
        def headers
            {
                'Content-type' => ' application/json'
            }
        end

        def endpoint
            return @end_point
        end
    
        def merchant_id
            return @openpay_id
        end
    end
end