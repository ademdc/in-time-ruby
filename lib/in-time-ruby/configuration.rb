module InTimeRuby
  class << self
    # Accessor for global configuration.
    attr_accessor :config
  end

  def self.configure
    self.config ||= Configuration.new
    yield(config) if block_given?
  end

  class Configuration
    attr_accessor :token_endpoint, :logger

    def initialize
      @token_endpoint = 'https://intime-ba.eu.auth0.com'
      @logger         =  InTimeRuby::Logger
    end
  end
end
