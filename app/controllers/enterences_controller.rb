class EnterencesController < ApplicationController
  before_action :authenticate_guest!, only: [:open_both]
  before_action :check_times, only: [:open_both]

  def guest
    @guest = Guest.new
  end

  def open_both
    if FrontDoor.open_door_and_elevator
      flash[:success] = "Door and Elevator are open. Wait 30 seconds before pressing again."
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
