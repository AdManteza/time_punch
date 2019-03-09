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

  describe '#update' do
    let(:teacher) { Teacher.find(1) }
    let(:time_track_params) do
      {
        time_track: {
          teacher_id: teacher.id,
          clock_in: Time.now - 60.minutes.ago,
          clock_out: Time.now
        }
      }
    end

    it 'updates the Time Track for a Teacher' do
      put :update, params: time_track_params

      expect(teacher.reload.clock_in).to eq(time_track_params[:clock_in])
      expect(teacher.reload.clock_out).to eq(time_track_params[:clock_out])
    end
  end

  describe '#destroy' do
    let(:teacher) { Teacher.find(1) }
    let(:time_track_params) do
      {
        time_track: {
          teacher_id: teacher.id,
          clock_in: Time.now - 60.minutes.ago,
          clock_out: Time.now
        }
      }
    end

    it 'destroys the Time Track for a Teacher' do
      expect do
        delete :destroy, params: time_track_params
      end.to change(TimeTrack, :count).by(-1)
    end
  end
end
