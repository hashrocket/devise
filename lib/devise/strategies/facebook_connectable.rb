module Devise
  module Strategies
    # Default strategy for signing in a user, based on his email and password.
    # Redirects to sign_in page if it's not authenticated
    class FacebookConnectable < Warden::Strategies::Base
      include Devise::Strategies::Base

      def valid?
        super && params[scope] && params[scope][:uid].present?
      end

      # Authenticate a user based on email and password params, returning to warden
      # success and the authenticated user if everything is okay. Otherwise redirect
      # to sign in page.
      def authenticate!
        if resource = mapping.to.fb_authenticate(params[scope])
          success!(resource)
        else
          fail!(:invalid)
        end
      end
    end
  end
end

Warden::Strategies.add(:facebook_connectable, Devise::Strategies::FacebookConnectable)
