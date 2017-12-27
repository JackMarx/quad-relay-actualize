class CloseJob < ApplicationJob
  queue_as :default

  def perform
    FrontDoor.close_door
    sleep 180
    FrontDoor.close_elevator
  end
end
