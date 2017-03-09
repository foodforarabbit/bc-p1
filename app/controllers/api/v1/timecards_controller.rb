class Api::V1::TimecardsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound do
    render status: 410, head: nil
  end

  def index
    timecards = Timecard.includes('time_entries').all
    render status: 200, json: timecards
  end

  def show
    timecard = Timecard.find(params[:id])
    render status: 200, json: timecard
  end

  def create
    timecard = Timecard.create(timecard_params)
    unless timecard.errors.any?
      return render status: 201, json: timecard
    end
    render status: 422, json: timecard.errors
  end

  def update
    timecard = Timecard.find(params[:id])
    timecard.update_attributes!(timecard_params)
    unless timecard.errors.any?
      return render status: 200, json: timecard
    end
    render status: 422, json: timecard.errors
  end

  def destroy
    timecard = Timecard.find(params[:id])
    if timecard && timecard.destroy
      return render status: 200, head: nil
    end

    render status: 422, head: nil
  end

  def timecard_params
    params.require(:timecard).permit(:username, :occurrence)
  end
end
