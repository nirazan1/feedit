class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception 
  #  It protects from csrf. e.g. all POST requests should have specific security token.

  before_action :authenticate_user!, except: [:index, :show]
  # authenticate user except for index and show
  
  before_filter :configure_permitted_parameters, if: :devise_controller?
  # custom field

  # before_filter :set_last_seen_at, if: proc { user_signed_in? && (session[:last_seen_at] == nil || session[:last_seen_at] < 5.minutes.ago) }

private
def set_last_seen_at
  current_user.update_attribute(:last_seen_at, Time.now)
  session[:last_seen_at] = Time.now
end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] =  "Access denied."
    redirect_to root_url
  end


  protected
      # custom field sanitization
      def configure_permitted_parameters
          devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name, :last_name, :username, :email, :about_me, :password, :avatar, :avatar_cache) }
          devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:first_name, :last_name, :username, :email, :about_me, :password, :current_password, :avatar, :avatar_cache) }
      end

end
