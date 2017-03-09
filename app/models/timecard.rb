class Timecard < ApplicationRecord # called Timecard instead of TimeCard to match the requested api endpoints.
  has_many :time_entries, dependent: :delete_all # no useful callbacks on time_entries when destroying timecard so this is quicker

  # helper function to set hours based on number of time_entries
  def update_total_hours
    if time_entries_count == 2
      update_attributes(total_hours: TimeEntry.calculate_total_hours_between(*time_entries.to_a))
    elsif time_entries_count < 2
      update_attributes(total_hours: nil)
    end
  end
end
