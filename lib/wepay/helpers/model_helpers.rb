module Wepay
  module Helpers
    module ModelHelpers
      def has_wepay_auth_code?
        wepay_auth_code.present?
      end
    end
  end
end