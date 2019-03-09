class TimeTrack < ApplicationRecord
  belongs_to :teacher

  def clocked_in_datetime
    clock_in.strftime("%b %d %Y %I:%M %p")
  end

  def clocked_out_datetime
    clock_out.strftime("%b %d %Y %I:%M %p")
  end
end
