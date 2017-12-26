Spree::OrdersController.class_eval do
    before_action :create_openpay_client, only: :update
    
    attr_accessor :auth_token, :openpay_id
     
    CONEKTA_API = "https://sandbox-api.openpay.mx/v1/"
    
    def create_openpay_client
        order_user = @order.user
        
        if order_user.nil?
            puts "Cannot create user in Openpay, user not defined in order"
            return
        end
        
        #We create the client via faraday in openpay if the openpay id is not defined
        if order_user.openpay_id.nil?
            openpay_card_method = Spree::PaymentMethod.find_by(:type => "Spree::BillingIntegration::OpenpayGateway::Card")
            
            #If the Payment Method is not defined we can not create the user without the private key
            unless openpay_card_method.nil?
                @auth_token = openpay_card_method.preferred_auth_token
                @openpay_id = openpay_card_method.preferred_openpay_id
                
                bill_address = @order.bill_address
                
                if bill_address.nil?
                    name = order_user.email
                    last_name = ""
                else
                    name = (bill_address.first_name? ? bill_address.first_name : order_user.email)
                    last_name = (bill_address.last_name? ? bill_address.last_name : "")
                end
                
                params = {
                    "name" => name,
                    "last_name" => last_name,
                    "email" => order_user.email,
                    "requires_account" => false
                }
        
                response = Oj.load connection.post(endpoint, Oj.dump(params)).body
                
                @success = !(response.eql?('null') || response.include?('category')) if response
                
                if @success
                    order_user.openpay_id = response['id']
                    
                    if order_user.save
                        puts "Openpay Client saved"
                    end
                else    
                    puts "Error when trying to connect to openpay server"
                    puts response['description']
                    
                    flash[:error] = "Openpay error: #{response['description']}"
                    redirect_to cart_path
                    return
                end
            else
                flash[:error] = "Openpay error: No openpay ID or auth token found"
                redirect_to cart_path
                return
            end
        end
    end
    
    def connection
        Faraday.new(url: CONEKTA_API + merchant_id + "/") do |faraday|
            faraday.request :url_encoded

            faraday.headers = headers
            faraday.adapter :typhoeus
            faraday.basic_auth(auth_token, nil)
        end
    end

    def headers
        {
            'Content-type' => ' application/json'
        }
    end

    def endpoint
        "customers"
    end
    
    def merchant_id
      return @openpay_id
    end
end