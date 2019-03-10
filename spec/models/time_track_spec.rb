require 'rails_helper'

RSpec.describe TimeTrack do
  let(:teacher) { create(:teacher) }

  subject { described_class.new }

  it 'should validate teacher' do
    subject.teacher = nil
    expect(subject).to_not be_valid
  end

  it 'should validate clock_in' do
    subject.teacher = teacher
    expect(subject).to_not be_valid
  end

  context 'clocking out happening before clocking in' do
    let(:clock_in)  { 'Sat, 09 Mar 2019 09:00:00 GMT' }
    let(:clock_out) { 'Sat, 09 Mar 2019 08:00:00 GMT' }

    it 'should be invalid' do
      subject.teacher   = teacher
      subject.clock_in  = clock_in
      subject.clock_out = clock_out

      expect(subject).to_not be_valid
    end
  end

  context 'attempt to clock_in again without clocking_out properly' do
    let(:initial_clock_in_for_today) { 'Sat, 09 Mar 2019 09:00:00 GMT' }
    let(:new_clock_in_for_today)     { 'Sat, 09 Mar 2019 10:00:00 GMT' }

    it 'should be invalid' do
      initial_time_track_for_today = create(:time_track, teacher_id: teacher.id, clock_in: initial_clock_in_for_today, clock_out: nil)

      subject.teacher  = teacher
      subject.clock_in = new_clock_in_for_today

      expect(subject).to_not be_valid
    end
  end
end
