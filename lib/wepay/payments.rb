module Wepay
  module Payments
    class Gateway
      include HTTParty

      base_uri @base_uri

      def initialize(*args)
        yml = Rails.root.join('config', 'wepay.yml').to_s
        @config = YAML.load_file(yml)[Rails.env].symbolize_keys
        @base_uri = Rails.env.production? ? "https://api.wepay.com" : "https://stage.wepay.com"
      end

      include Wepay::Payments::Helpers
    end

    def gateway
      @gateway ||= Gateway.new
    end
  end
end