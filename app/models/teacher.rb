class Teacher < ApplicationRecord
  has_many :time_tracks

  validates_presence_of :first_name, :last_name, :time_punch_code
  validates_uniqueness_of :time_punch_code
end
