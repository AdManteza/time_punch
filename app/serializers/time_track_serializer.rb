class TimeTrackSerializer < ActiveModel::Serializer
  attributes :first_name, :last_name, :clock_in, :clock_out

  def first_name
    time_track.teacher.first_name
  end

  def last_name
    time_track.teacher.last_name
  end

  def clock_in
    return if time_track.clock_in.nil?

    time_track.clock_in.
      in_time_zone(TimeTrack::DefaultTimeZone).
      strftime("%b %d %Y %I:%M:%S %p")
  end

  def clock_out
    return if time_track.clock_out.nil?

    time_track.clock_out.
      in_time_zone(TimeTrack::DefaultTimeZone).
      strftime("%b %d %Y %I:%M:%S %p")
  end

private

  def time_track
    @object
  end
end
