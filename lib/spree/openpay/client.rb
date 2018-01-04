module Spree::Openpay
  module Client
    attr_accessor :auth_token
    
    def post(params)
      Oj.load connection.post(endpoint, Oj.dump(params)).body
    end

    def get
      Oj.load connection.get(endpoint).body
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
      raise 'Not Implemented'
    end
    
    def headers
      {
        'Content-type' => ' application/json'
      }
    end

    def endpoint
      raise 'Not Implemented'
    end
    
    def merchant_id
      raise 'Not Implemented'
    end
  end
end
