require "rails_helper"

RSpec.describe TimeTracksController do
  describe '#new' do
    it 'should be ok' do
      get :new

      expect(response).to render_template(:new)
      expect(assigns(:time_track)).to be_truthy
    end
  end

  describe '#create' do
    let(:time_track_params) do
      {
        time_track: {
          teacher_id: 1,
          clock_in: Time.now,
          clock_out: nil
        }
      }
    end

    it 'creates a new Time Track for a Teacher' do
      expect do
        post :create, params: time_track_params
      end.to change(TimeTrack, :count).by(1)
    end
  end
end
