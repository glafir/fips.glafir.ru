#require "application_responder"

class ApplicationController < ActionController::Base
#  self.responder = ApplicationResponder
  respond_to :html

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :authenticate_user!
  protect_from_forgery with: :exception

  def set_timezone
    tz = current_user ? current_user.time_zone : nil
    Time.zone = tz || ActiveSupport::TimeZone["Moscow"]
  end


  def after_sign_in_path_for(resource)
#    @flash = flash[:notice]
#    @flash_message_state_id = 100
#    flash_message_add
    current_user
  end
end
