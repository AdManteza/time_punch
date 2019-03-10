require 'rails_helper'

RSpec.describe Teacher do
  subject { described_class.new }

  it 'validates first name' do
    subject.first_name = ''
    subject.last_name  = 'LastName'
    subject.time_punch_code = 'DUH123'

    expect(subject).to_not be_valid
  end

  it 'validates last_name' do
    subject.first_name = 'FirstName'
    subject.last_name  = ''
    subject.time_punch_code = 'DUH123'

    expect(subject).to_not be_valid
  end

  context 'time punch code' do
    it 'should be present' do
      subject.first_name = 'FirstName'
      subject.last_name  = 'LastName'
      subject.time_punch_code = ''

      expect(subject).to_not be_valid
    end

    it 'should be unique' do
      existing_teacher   = create(:teacher)
      subject.first_name = 'FirstName'
      subject.last_name  = 'LastName'
      subject.time_punch_code = existing_teacher.time_punch_code

      expect(subject).to_not be_valid
    end
  end
end
