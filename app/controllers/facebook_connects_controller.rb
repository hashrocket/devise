class FacebookConnectsController < ApplicationController
  include Devise::Controllers::Helpers

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
      params[resource_name] = {:facebook_uid => $1, :email => '', :encrypted_password => 'fb', :password_salt => 'fb' }
    end
    resource = build_resource
    resource.save(false)
    resource.confirmed_at = Time.now
    resource.confirmation_token = nil
    resource.save(false)

    sign_in_and_redirect(resource)
  end
end

