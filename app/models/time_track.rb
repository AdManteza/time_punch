class TimeTrack < ApplicationRecord
  belongs_to :teacher

  validates_presence_of :teacher_id, :clock_in
  validate :clocking_out, :clocking_in

  scope :teacher_clock_in_for_date, -> (teacher, date) do
    where(teacher_id: teacher.id).
      where('clock_in BETWEEN ? AND ?', date.to_date.beginning_of_day, date.to_date.end_of_day)
  end

  scope :no_clock_out, -> do
    where('clock_in IS NOT NULL AND clock_out IS NULL')
  end

  def clocked_in_datetime
    clock_in.strftime("%b %d %Y %I:%M %p")
  end

  def clocked_out_datetime
    clock_out.strftime("%b %d %Y %I:%M %p")
  end

private

  def clocking_out
    return unless clock_in.present? && clock_out.present?

    if clock_out < clock_in
      errors.add(:clock_out, 'Clock Out Time must happen after Clock In Time!')
    end
  end

  def clocking_in
    return unless clock_in.present?

    errors.add(:clock_in, 'You must Clock Out first!') if did_not_clock_out_previously?
  end

  def did_not_clock_out_previously?
    TimeTrack.teacher_clock_in_for_date(teacher, clock_in.to_date).
      no_clock_out.present?
  end
end
