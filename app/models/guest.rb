class Guest < ApplicationRecord
  has_secure_password
  belongs_to :group
  has_many :time_slots, through: :group

  def full_name
    "#{first_name} #{last_name}"
  end

  def valid_time?
    time_slots.select {|time_slot| time_slot.current? }.any?
  end
end
