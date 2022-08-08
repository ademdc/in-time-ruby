module InTimeRuby
  class Connection

    attr_reader :client, :base_url, :client_id, :client_secret

    def initialize(base_url, client_id, client_secret, with_logger: false)
      @base_url = base_url
      @client_id = client_id
      @client_secret = client_secret

      @client = InTimeRuby::Client.new(base_url, client_id, client_secret, with_logger: with_logger)
    end

    def get_shipment(id)
      action("/api/shipments/#{id}", http_method: :get)
    end

    def create_shipment(payload)
      action("/api/shipments", payload: payload)
    end

    def confirm_shipment(trackingNumber)
      action("/api/shipments/confirmshipments?trackingNumber=#{trackingNumber}", http_method: :put)
    end

    def update_shipment(id, payload)
      action("/api/shipments/#{id}", payload: payload, http_method: :patch)
    end

    def get_shipment_events(id)
      action("/api/shipments/#{id}/shipmentevents", http_method: :get)
    end

    private

    def action(path, payload: {}, http_method: :post)
      client.action(path, payload: payload, http_method: http_method)
    end
  end
end