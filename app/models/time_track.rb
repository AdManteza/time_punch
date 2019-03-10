class TimeTrack < ApplicationRecord
  belongs_to :teacher

  validates_presence_of :teacher_id, :clock_in
  validate :clock_out_after_clock_in
  validate :clocking_in, on: :create

  scope :for_date, -> (date) do
    where('clock_in BETWEEN ? AND ?', date.to_date.beginning_of_day, date.to_date.end_of_day)
  end

  scope :for_teacher, -> (teacher) do
    where(teacher_id: teacher.id)
  end

  scope :no_clock_out, -> do
    where.not(clock_in: nil).where(clock_out: nil)
  end

  # Hardcoded for now. Ideally we should be creating a model
  # called "DayCareCentre" where time zone name is stored
  DefaultTimeZone = 'Eastern Time (US & Canada)'.freeze

private

  def clock_out_after_clock_in
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
    self.class.for_date(clock_in.to_date).
      for_teacher(teacher).
      no_clock_out.present?
  end
end
