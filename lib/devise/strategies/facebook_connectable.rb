module Devise
  module Strategies
    # Strategy to connect via facebook_uid if it exists
    class FacebookConnectable < Warden::Strategies::Base
      include Devise::Strategies::Base

      def valid?
        super && params[scope] && params[scope][:facebook_uid].present?
      end

      # Authenticate a user based on email and password params, returning to warden
      # success and the authenticated user if everything is okay. Otherwise redirect
      # to sign in page.
      def authenticate!
        if resource = mapping.to.fb_authenticate(params[scope])
          success!(resource)
        else
          redirect!("/#{scope.to_s.pluralize}/facebook_connect_create", params)
        end
      end
    end
  end
end

Warden::Strategies.add(:facebook_connectable, Devise::Strategies::FacebookConnectable)
