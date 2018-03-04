class SessionsController < ApplicationController
  def create
    guest = Guest.find_by(email: session_params[:email])
    puts "************"
    p guest
    puts "************"
    
    if guest && guest.authenticate(session_params[:password])
      session[:user_id] = guest.id
    else
      flash["message"] = "Please check your email and password. If problem persists, contact Actualize staff at operations@actualize.co for help."
    end
    redirect_to '/'
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/'
  end

private
  
  def session_params
    params.require(:guest).permit(:email, :password)
  end
end
