class TimeEntry < ApplicationRecord
  TIME_IS_TIME = true # are we using TimeEntry.time for the time only, or as a DateTime (e.g. as time, if given Jan 1, 5:00 am and Jan 2, 6:00 am we calculate 1 for total_hours instead of 25)

  belongs_to :timecard, :counter_cache => true # uses a counter_cache so we don't need to keep hitting the db to get a count of time_entries.
  after_commit :update_previous_timecard_total_hours # make sure to update total_hours on "previous" timecard if any
  after_destroy :update_timecard_total_hours # update total_hours on timecard

  validates :time, presence: true # time_entry must have time
  validates :timecard, presence: true # time_entry must be associated with a timecard

  # class helper function to calculate number of hours between two time_entries
  def self.calculate_total_hours_between time_entry1, time_entry2
    return if (time_entry1.nil? || time_entry2.nil? || time_entry1.time.nil? || time_entry2.time.nil?)
    time2 = time_entry2.time
    time1 = time_entry1.time
    (TIME_IS_TIME ? time2.to_i - time2.beginning_of_day.to_i - time1.to_i + time1.beginning_of_day.to_i : time2.to_i - time1.to_i) / 3600.0 # use 3600 if we want full hours
  end

  private

  def update_previous_timecard_total_hours
    timecard_id_changes = previous_changes["timecard_id"]
    unless timecard_id_changes.nil?
      previous_timecard = Timecard.find_by(id: timecard_id_changes[0])
      unless previous_timecard.nil?
        previous_timecard.update_total_hours
      end
    end
    update_timecard_total_hours
  end

  def update_timecard_total_hours
    unless timecard.reload.nil?
      timecard.update_total_hours
    end
  end
end
