class Group < ApplicationRecord
  has_many :time_slots
  has_many :guests
end
