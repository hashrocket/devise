class FacebookConnectsController < ApplicationController
  include Devise::Controllers::InternalHelpers
  include Devise::Controllers::Common

  # before_filter :require_no_authentication

  # GET /resource/new
  def new
    if params[:session][/\"uid\":(\d+)/]
      params[resource_name] = {:facebook_uid => $1}
    end

    if authenticate!(resource_name)
      set_flash_message :success, :signed_in
    end

    sign_in_and_redirect(resource_name)
  end

  def create
    if params[:session][/\"uid\":(\d+)/]
      params[resource_name] = { :facebook_uid => $1,
        :email => '',
        :encrypted_password => 'fb',
        :password_salt => 'fb' }
    end

    if build_resource.class.ancestors.include?(Devise::Models::Confirmable)
      resource.skip_confirmation!
    end

    resource.save(false)

    sign_in_and_redirect(resource)
  end
end

