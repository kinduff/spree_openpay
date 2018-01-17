# Spree::OrdersController.class_eval do
#     #before_action :create_openpay_client, only: :update
    
#     attr_accessor :openpay_api, :auth_token, :openpay_id
     
#     def create_openpay_client
#         order_user = @order.user
        
#         if order_user.nil?
#             puts "Cannot create user in Openpay, user not defined in order"
#             return
#         end
        
#         #We create the client via faraday in openpay if the openpay id is not defined
#         if order_user.openpay_id.nil?
#             #We find the payment method for openpay, it needs to be active
#             openpay_method = Spree::PaymentMethod.find_by(:type => "Spree::BillingIntegration::OpenpayGateway::Card", :active => true)
            
#             if openpay_method.nil?
#                 openpay_method = Spree::PaymentMethod.find_by(:type => "Spree::BillingIntegration::OpenpayGateway::Cash", :active => true)
#             end
            
#             #If the Payment Method is not defined we can not create the user without the private key
#             unless openpay_method.nil?
#                 #If payment method is for card and it contains the use_wallet preference
#                 unless openpay_method.try(:preferred_use_wallet).nil?
#                     unless openpay_method.preferred_use_wallet
#                         puts "Customer Wallet Disabled"
#                         return
#                     end
#                 else
#                     puts "Cash Payment Method, Wallet not needed"
#                     return
#                 end
                
#                 @openpay_api = openpay_method.preferred_test_mode
#                 @auth_token = openpay_method.preferred_auth_token
#                 @openpay_id = openpay_method.preferred_openpay_id
                
#                 bill_address = @order.bill_address
                
#                 if bill_address.nil?
#                     name = order_user.email
#                     last_name = ""
#                 else
#                     name = (bill_address.first_name? ? bill_address.first_name : order_user.email)
#                     last_name = (bill_address.last_name? ? bill_address.last_name : "")
#                 end
                
#                 params = {
#                     "name" => name,
#                     "last_name" => last_name,
#                     "email" => order_user.email,
#                     "requires_account" => false
#                 }
        
#                 response = Oj.load connection.post(endpoint, Oj.dump(params)).body
                
#                 @success = !(response.eql?('null') || response.include?('category')) if response
                
#                 if @success
#                     order_user.openpay_id = response['id']
                    
#                     if order_user.save
#                         puts "Openpay Client saved"
#                     end
#                 else    
#                     puts "Error when trying to connect to openpay server"
#                     puts response['description']
                    
#                     flash[:error] = "Openpay error: #{response['description']}"
#                     redirect_to cart_path
#                     return
#                 end
#             else
#                 #flash[:error] = "Openpay error: No openpay ID or auth token found"
#                 #redirect_to cart_path
#                 puts "No Openpay Payment Method found, proceed as normal"
#                 return
#             end
#         end
#     end
    
#     def connection
#         Faraday.new(url: openpay_url + merchant_id + "/") do |faraday|
#             faraday.request :url_encoded

#             faraday.headers = headers
#             faraday.adapter :typhoeus
#             faraday.basic_auth(auth_token, nil)
#         end
#     end

#     def openpay_url
#         if @openpay_api
#             "https://sandbox-api.openpay.mx/v1/"
#         else
#             "https://dev-api.openpay.mx/v1/"
#         end
#     end
    
#     def headers
#         {
#             'Content-type' => ' application/json'
#         }
#     end

#     def endpoint
#         "customers"
#     end
    
#     def merchant_id
#         return @openpay_id
#     end
# end