require 'devise/strategies/facebook_connectable'
require 'devise/serializers/facebook_connectable'

module Devise
  module Models

    # FacebookConnectable Module, responsible for encrypting password and validating
    # authenticity of a user while signing in.
    #
    # Configuration:
    #
    # You can overwrite configuration values by setting in globally in Devise,
    # using devise method or overwriting the respective instance method.
    #
    #   pepper: encryption key used for creating encrypted password. Each time
    #           password changes, it's gonna be encrypted again, and this key
    #           is added to the password and salt to create a secure hash.
    #           Always use `rake secret' to generate a new key.
    #
    #   stretches: defines how many times the password will be encrypted.
    #
    #   encryptor: the encryptor going to be used. By default :sha1.
    #
    #   authentication_keys: parameters used for authentication. By default [:email]
    #
    # Examples:
    #
    #    User.authenticate('email@test.com', 'password123')  # returns authenticated user or nil
    #    User.find(1).valid_password?('password123')         # returns true/false
    #
    module FacebookConnectable
      def self.included(base)
        base.class_eval do
          extend ClassMethods
        end
      end

      protected

      module ClassMethods
        # Authenticate a user based on configured attribute keys. Returns the
        # authenticated user if it's valid or nil. Attributes are by default
        # :email and :password, but the latter is always required.
        def fb_authenticate(attributes={})
          return unless attributes[:uid]
          conditions = "facebook_uid = '#{attributes[:uid]}'"
          find_for_authentication(conditions)
        end

      end
    end
  end
end
