class TimeTracksController < ApplicationController
  before_action :teacher, only: [:create, :update]
  before_action :time_track, only: [:update]

  def index
    @time_tracks = TimeTrack.all
  end

  def new
    @time_track = TimeTrack.new
  end

  def create
    @time_track = TimeTrack.new(time_track_params)

    respond_to do |format|
      if @time_track.save
        format.json { render json: @time_track }
      else
        format.json { render json: @time_track.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if time_track.update(time_track_params)
        format.json { render json: time_track }
      else
        format.json { render json: time_track.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    time_track.destroy
  end

private

  def teacher
    @teacher ||= Teacher.find(time_track_params[:teacher_id])
  rescue ActiveRecord::RecordNotFound => boom
    render json: boom.message, status: :unprocessable_entity
  end

  def time_track
    @time_track ||= TimeTrack.find(params[:id])
  end

  def time_track_params
    params.fetch(:time_track).permit(
      :teacher_id,
      :clock_in,
      :clock_out
    )
  end
end
