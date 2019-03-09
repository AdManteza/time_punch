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
    let(:time_track_params) { attributes_for(:time_track) }

    context 'everything is fine' do
      it 'creates a new Time Track for a Teacher' do
        expect do
          post :create, format: :json, params: { time_track: time_track_params.merge(teacher_id: teacher.id) }
        end.to change(TimeTrack, :count).by(1)
      end
    end

    context 'cannot find the Teacher' do
      it 'raises an error' do
        expect do
          post :create, format: :json, params: { time_track: time_track_params.merge(teacher_id: 0) }
        end.to_not change(TimeTrack, :count)

        expect(response.status).to eq 422
        expect(response.body).to be_truthy
      end
    end

    context 'error on saving' do
      it 'raises an error' do
        expect_any_instance_of(TimeTrack).to receive(:save).and_return(false)

        expect do
          post :create, format: :json, params: { time_track: time_track_params.merge(teacher_id: teacher.id) }
        end.to_not change(TimeTrack, :count)

        expect(response.status).to eq 422
        expect(response.body).to be_truthy
      end
    end
  end

  describe '#update' do
    let(:teacher)   { create(:teacher) }
    let(:clock_in)  { 'Sat, 09 Mar 2019 09:00:00 GMT' }
    let(:clock_out) { 'Sat, 09 Mar 2019 17:00:00 GMT' }
    let(:time_track) do
      create(:time_track, teacher_id: teacher.id, clock_in: clock_in, clock_out: nil)
    end
    let(:time_track_params) do
      {
        id: time_track.id,
        time_track: {
          teacher_id: teacher.id,
          clock_out: clock_out
        }
      }
    end

    context 'everything is fine' do
      it 'updates the Time Track for a Teacher' do
        put :update, format: :json, params: time_track_params

        expect(time_track.reload.clock_in).to eq(clock_in)
        expect(time_track.reload.clock_out).to eq(clock_out)
      end
    end

    context 'cannot find the Teacher' do
      it 'raises an error' do
        put :update, format: :json, params: time_track_params.deep_merge(time_track: { teacher_id: 0 })

        expect(response.status).to eq 422
        expect(response.body).to be_truthy
        expect(time_track.reload.clock_in).to eq(clock_in)
        expect(time_track.reload.clock_out).not_to eq(clock_out)
      end
    end

    context 'error on update' do
      it 'raises an error' do
        expect_any_instance_of(TimeTrack).to receive(:update).and_return(false)

        put :update, format: :json, params: time_track_params

        expect(response.status).to eq 422
        expect(response.body).to be_truthy
        expect(time_track.reload.clock_in).to eq(clock_in)
        expect(time_track.reload.clock_out).not_to eq(clock_out)
      end
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
