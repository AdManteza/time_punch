class TimeTracksController < ApplicationController
  before_action :teacher, only: [:create, :update]
  before_action :time_track, only: [:update]
  before_action :time_tracks, only: [:index]

  def index
    respond_to do |format|
      format.json { render json: @time_tracks }
    end
  end

  def create
    @time_track = teacher.time_tracks.build(time_track_params)

    respond_to do |format|
      if @time_track.save
        format.json { render json: @time_track }
      else
        errors = validation_errors(@time_track.errors)

        format.json { render json: errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if time_track.update(time_track_params)
        format.json { render json: time_track }
      else
        errors = validation_errors(time_track.errors)

        format.json { render json: errors, status: :unprocessable_entity }
      end
    end
  end

private

  # Find the teacher thru its Time Punch code
  def teacher
    @teacher ||= begin
      record = Teacher.find_by_time_punch_code(params[:teacher_id])

      raise ActiveRecord::RecordNotFound if record.nil?

      record
    end
  rescue ActiveRecord::RecordNotFound
    message = 'Teacher not found!'

    render json: [message], status: :unprocessable_entity
  end

  # find the time_track that the teacher
  # will be clocking_out from
  def time_track
    @time_track ||= begin
      record = teacher.time_tracks.
               for_date(time_track_params[:clock_out].to_date).
               no_clock_out.first

      raise ActiveRecord::RecordNotFound if record.nil?

      record
    end
  rescue ActiveRecord::RecordNotFound
    message = 'Time Track not found!'

    render json: [message], status: :unprocessable_entity
  end

  def time_tracks
    @time_tracks ||= TimeTrack.includes(:teacher)
  end

  def validation_errors(time_track_errors)
    time_track_errors.values.flatten
  end

  def time_track_params
    params.fetch(:time_track).permit(
      :clock_in,
      :clock_out
    )
  end
end
