require 'rails_helper'

RSpec.describe TimeTracksController do
  describe '#index' do
    it 'should be ok' do
      get :index

      expect(response).to render_template(:index)
      expect(assigns(:time_tracks)).to be_truthy
    end
  end

  describe '#new' do
    it 'should be ok' do
      get :new

      expect(response).to render_template(:new)
      expect(assigns(:time_track)).to be_truthy
    end
  end

  describe '#create' do
    let(:teacher)  { create(:teacher) }
    let(:clock_in) { 'Sat, 09 Mar 2019 09:00:00 GMT' }

    context 'everything is fine' do
      it 'creates a new Time Track for a Teacher' do
        expect do
          post :create, format: :json, params: { teacher_id: teacher.id, time_track: { clock_in: clock_in } }
        end.to change(TimeTrack, :count).by(1)
      end
    end

    context 'cannot find the Teacher' do
      it 'raises an error' do
        expect do
          post :create, format: :json, params: { teacher_id: 0, time_track: { clock_in: clock_in } }
        end.to_not change(TimeTrack, :count)

        expect(response.status).to eq 422
        expect(response.body).to be_truthy
      end
    end

    context 'error on saving' do
      it 'raises an error' do
        expect_any_instance_of(TimeTrack).to receive(:save).and_return(false)

        expect do
          post :create, format: :json, params: { teacher_id: teacher.id, time_track: { clock_in: clock_in } }
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

    context 'everything is fine' do
      it 'updates the Time Track for a Teacher' do
        time_track = create(:time_track, teacher_id: teacher.id, clock_in: clock_in, clock_out: nil)

        put :update, format: :json, params: { teacher_id: teacher.id, time_track: { clock_out: clock_out } }

        expect(time_track.reload.clock_in).to eq(clock_in)
        expect(time_track.reload.clock_out).to eq(clock_out)
      end
    end

    context 'cannot find the Teacher' do
      it 'raises an error' do
        time_track = create(:time_track, teacher_id: teacher.id, clock_in: clock_in, clock_out: nil)

        put :update, format: :json, params: { teacher_id: 0, time_track: { clock_out: clock_out } }

        expect(response.status).to eq 422
        expect(response.body).to be_truthy
        expect(time_track.reload.clock_in).to eq(clock_in)
        expect(time_track.reload.clock_out).not_to eq(clock_out)
      end
    end

    context 'error on update' do
      it 'raises an error' do
        time_track = create(:time_track, teacher_id: teacher.id, clock_in: clock_in, clock_out: nil)

        expect_any_instance_of(TimeTrack).to receive(:update).and_return(false)

        put :update, format: :json, params: { teacher_id: teacher.id, time_track: { clock_out: clock_out } }

        expect(response.status).to eq 422
        expect(response.body).to be_truthy
        expect(time_track.reload.clock_in).to eq(clock_in)
        expect(time_track.reload.clock_out).not_to eq(clock_out)
      end
    end
  end
end
