module Wepay
  module Payments
    module Helpers
      # Get the auth code for the customer
      # arguments are the redirect_uri and an array of permissions that your application needs
      # ex. ['manage_accounts','collect_payments','view_balance','view_user']
      def auth_code_url(redirect_uri, permissions)
        params = {
            :client_id => @config[:client_id],
            :redirect_uri => redirect_uri,
            :scope => permissions.join(',')
        }

        query = params.map do |k, v|
          "#{k.to_s}=#{v}"
        end.join('&')

        "#{@base_uri}/v2/oauth2/authorize?#{query}"
      end
    end
  end
end