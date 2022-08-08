require 'rest-client'
require 'json'
require "base64"

module InTimeRuby
  class Client
  
    attr_reader :base_url, :client_id, :client_secret, :with_authorization, :with_logger

    def initialize(base_url, client_id, client_secret, with_authorization: true, with_logger: false)
      @base_url = base_url
      @client_id = client_id
      @client_secret = client_secret
      @with_authorization = with_authorization
      @with_logger = with_logger
    end

    def action(path, http_method: :post, payload: {}, query_params: {})
      begin 
        response = ::RestClient::Request.execute(
          method: http_method,
          url: full_url(path),
          payload: payload.to_json,
          headers: headers,
          timeout: 5,
          verify_ssl: ::OpenSSL::SSL::VERIFY_NONE
        )
      rescue => e
        return struct_response.new(false, { error: parse(e.response), message: e.message })
      end

      parse(response)
    end

    private

    def get_auth_token
      unless access_token_generator.token_expired?
        print_log "Using existing token"
        return access_token_generator.get_access_token 
      end
      
      print_log "Generating new token"
      
      response = access_token_generator.generate_token
      access_token_generator.save_to_thread!(response)
      access_token_generator.get_access_token
    end

    def headers
      headers = {
        'User-Agent': "Ruby In Time client v#{InTimeRuby::VERSION})",
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      }

      headers['Authorization'] = "Bearer #{get_auth_token}" if with_authorization
      headers 
    end

    def full_url(path)
      "#{base_url}#{path}"
    end

    def parse(response)
      success       = (200..308).to_a.include?(response.code.to_i) ? true : false
      hash_response = response.body.empty? ? response.body : JSON.parse(response.body)

      struct_response.new(success, hash_response)
    end

    def struct_response
      Struct.new(:success?, :hash_response)
    end

    def access_token_generator
      @access_token_generator ||= ::InTimeRuby::AccessTokenGenerator.new(client_id, client_secret)
    end

    def print_log(log, debug_type: :info)
      if with_logger
        InTimeRuby.config.logger.send debug_type, "<---- #{log} ----->"
      end
    end
  end
end