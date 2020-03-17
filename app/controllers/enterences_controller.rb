class EnterencesController < ApplicationController
  before_action :authenticate_guest!, only: [:open_both]
  before_action :check_times, only: [:open_both]

  def guest
    @guest = Guest.new

    if params[:bypass] == "true" # for COVID19 temp
      @bypass = true
    end
  end

  def open_both
    if FrontDoor.open_door_and_elevator
      if current_guest
        puts "*****************"
        puts "#{current_guest.first_name} #{current_guest.last_name} just logged in"
        puts "*****************"
      end
      
      flash[:success] = "Door and Elevator are open."
      CloseJob.set(wait: 30.seconds).perform_later
    else
      flash[:danger] = "Failed to Open Door"
    end
    redirect_to "/"
  end

private
  
  def check_times
    unless current_guest.valid_time?
      flash[:warning] = "Please come back during scheduled hours"
      redirect_to '/' 
    end
  end
end
