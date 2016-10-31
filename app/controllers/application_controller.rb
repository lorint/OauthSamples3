class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    user_id = session[:user_id]
    @current_user ||= User.find_by(id: session[:user_id]) unless user_id.nil?
  end
end
