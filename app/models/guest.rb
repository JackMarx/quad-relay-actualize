class Guest < ApplicationRecord
  has_secure_password
  belongs_to :group
  has_many :time_slots, through: :group
  validates :email, uniqueness: true

  def full_name
    "#{first_name} #{last_name}"
  end

  def valid_time?
    
    if group_id == 2
      true
    elsif start_date < Time.now.getlocal
      time_slots.select {|time_slot| time_slot.current? }.any?
    end
  end
end
