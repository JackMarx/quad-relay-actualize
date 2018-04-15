class EnterencesController < ApplicationController
  before_action :authenticate_guest!, only: [:open_both]
  before_action :check_times, only: [:open_both]

  def guest
    @guest = Guest.new
  end

  def open_both
    puts "11111111111 it starts 1111111111111"
    FrontDoor.open_door_and_elevator
    CloseJob.set(wait: 30.seconds).perform_later
    redirect_to "/"
  end

private
  
  def check_times
    redirect_to '/' unless current_guest.valid_time?
  end
end
