class Users::RegistrationsController < Devise::RegistrationsController
#  before_action :check_permissions, :only => [:new, :create, :cancel, :edit, :update]
#  skip_before_filter :require_no_authentication
#  before_action :configure_permitted_parameters

  protected

  def check_permissions
#    authorize :user_registration
  end

#  def update_resource(resource, params)
#    resource.update_without_password(params)
#  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up).push(:username, :email, :time_zone)
    devise_parameter_sanitizer.for(:account_update).push(:username, :email, :time_zone)
  end

  def after_update_path_for(resource)
#    @flash = flash[:notice]
#    @flash_message_state_id = 202
#    flash_message_add
    user_path(resource)
  end
end
