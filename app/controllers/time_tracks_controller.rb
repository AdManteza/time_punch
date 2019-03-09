class TimeTracksController < ApplicationController
  before_action :teacher, only: [:create, :update]

  def new
    @time_track = TimeTrack.new
  end

  def create
  end

  def update
  end

  def destroy

  end

private

  def teacher
    @teacher ||= Teacher.find(time_track_params[:teacher_id])
  end

  def time_track_params
    params.fetch(:time_track).permit(
      :teacher_id,
      :clock_in,
      :clock_out
    )
  end
end
