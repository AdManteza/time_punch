FactoryBot.define do
  factory :teacher do
    name 'Teacher1'
  end

  factory :time_track do
    clocked_in  = 8.hours.ago
    clocked_out = clocked_in + 8.hours

    teacher
    clock_in  { clocked_in }
    clock_out { clocked_out }
  end
end
