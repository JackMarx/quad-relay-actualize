class EnterencesController < ApplicationController
  before_action :authenticate_guest!, only: [:open_both]

  def guest
    @guest = Guest.new
  end

  def open_both
    FrontDoor.open_door_and_elevator
    CloseJob.set(wait: 30.seconds).perform_later
    redirect_to "/"
  end

private
  
  def check_times
    current_guest.times
  end
end
