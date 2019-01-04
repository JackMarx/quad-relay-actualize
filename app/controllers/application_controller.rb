class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

private

  def current_guest
    @user ||= Guest.find_by(id: session[:user_id]) if session[:user_id]
  end
  helper_method :current_guest

  def authenticate_guest!
    redirect_to '/' unless current_guest
  end

  # def authenticate_admin! # for creating guests by browser need email set up first.
  #   redirect_to '/' unless current_guest.admin
  # end
end
