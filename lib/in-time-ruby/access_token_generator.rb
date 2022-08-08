
module InTimeRuby
  class AccessTokenGenerator

    attr_reader :client, :client_id, :client_secret

    def initialize(client_id, client_secret)
      @client_id = client_id
      @client_secret = client_secret

      @client = InTimeRuby::Client.new(token_generation_endpoint, client_id, client_secret, with_authorization: false)
    end

    def generate_token
      payload = {
        client_id: client_id,
        client_secret: client_secret,
        audience: "https://api.intimebatnr.com",
        grant_type: "client_credentials"
      }

      client.action('/oauth/token', payload: payload)
    end

    def token_expired?
      return true unless expire_datetime

      Time.now > expire_datetime
    end

    def get_access_token
      Thread.current["access_token_#{client_id}"]
    end

    def save_to_thread!(response)
      save_to_thread(response)
    end

    private

    def save_to_thread(response)
      [:access_token, :expires_in, :token_type, :scope].each do |key|
        Thread.current["#{key}_#{client_id}"] = response.hash_response.dig(key.to_s)
      end

      Thread.current["expire_datetime_#{client_id}"] = Time.now + response.hash_response.dig('expires_in')
    end

    def expire_datetime
      Thread.current["expire_datetime_#{client_id}"]
    end

    def token_generation_endpoint
      InTimeRuby.config.token_endpoint
    end
  end
end