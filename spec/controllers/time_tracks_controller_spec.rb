require 'rails_helper'

RSpec.describe TimeTracksController do
  describe '#new' do
    it 'should be ok' do
      get :new

      expect(response).to render_template(:new)
      expect(assigns(:time_track)).to be_truthy
    end
  end

  describe '#create' do
    let(:teacher)           { create(:teacher) }
    let(:time_track_params) { attributes_for(:time_track).merge(teacher_id: teacher.id) }

    it 'creates a new Time Track for a Teacher' do
      expect do
        post :create, format: :json, params: { time_track: time_track_params }
      end.to change(TimeTrack, :count).by(1)
    end
  end

  describe '#update' do
    let(:teacher)   { create(:teacher) }
    let(:clock_in)  { Time.zone.now - 1.hour.ago }
    let(:clock_out) { Time.zone.now }
    let(:time_track) do
      create(:time_track, teacher: teacher, clock_in: clock_in, clock_out: nil)
    end

    it 'updates the Time Track for a Teacher' do
      put :update, params: { id: time_track.id, time_track: { clock_out: clock_out} }

      expect(teacher.reload.clock_in).to eq(time_track.clock_in)
      expect(teacher.reload.clock_out).to eq(clock_out)
    end
  end

  describe '#destroy' do
    let(:time_track) { create(:time_track) }

    it 'destroys the Time Track for a Teacher' do
      expect do
        delete :destroy, id: time_track.id
      end.to change(TimeTrack, :count).by(-1)
    end
  end
end
