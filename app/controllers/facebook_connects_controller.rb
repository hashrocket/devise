class FacebookConnectsController < ApplicationController
  include Devise::Controllers::Helpers

  # before_filter :require_no_authentication

  # GET /resource/new
  def new
    if params[:session][/\"uid\":(\d+)/]
      params[resource_name] = {:facebook_uid => nil}
      params[resource_name] = {:facebook_uid => $1}
    end

    p params
    if authenticate(resource_name)
      set_flash_message :success, :signed_in
    else
      resource = build_resource
      resource.save(false)
    end

    p resource
    sign_in_and_redirect(resource_name)

  end
end

