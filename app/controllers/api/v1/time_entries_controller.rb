class Api::V1::TimeEntriesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound do
    render status: 410, head: nil
  end

  def index
    time_entries = TimeEntry.all
    render status: 200, json: time_entries
  end

  def show
    time_entry = TimeEntry.find(params[:id])
    render status: 200, json: time_entry
  end

  def create
    time_entry = TimeEntry.create(time_entry_params)
    unless time_entry.errors.any?
      return render status: 201, json: time_entry
    end
    render status: 422, json: time_entry.errors
  end

  def update
    time_entry = TimeEntry.find(params[:id])
    time_entry.update_attributes!(time_entry_params)
    unless time_entry.errors.any?
      return render status: 200, json: time_entry
    end
    render status: 422, json: time_entry.errors
  end

  def destroy
    time_entry = TimeEntry.find(params[:id])
    if time_entry && time_entry.destroy
      return render status: 200, json: time_entry
    end

    render status: 422, head: nil
  end

  def time_entry_params
    params.require(:time_entry).permit(:time, :timecard_id)
  end
end
