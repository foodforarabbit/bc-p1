class Api::V1::BioPushController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound do
    render status: 410, head: nil
  end

  def index
    bio_pushes = BioPush.all
    render status: 200, json: bio_pushes
  end

  def show
    bio_push = BioPush.find(params[:id])
    render status: 200, json: bio_push
  end

  def create
    bio_push = BioPush.create(bio_push_params)
    unless bio_push.errors.any?
      return render status: 201, json: bio_push
    end
    render status: 422, json: bio_push.errors
  end

  def update
    bio_push = BioPush.find(params[:id])
    bio_push.update_attributes!(bio_push_params)
    unless bio_push.errors.any?
      return render status: 200, json: bio_push
    end
    render status: 422, json: bio_push.errors
  end

  def destroy
    bio_push = BioPush.find(params[:id])
    if bio_push && bio_push.destroy
      return render status: 200, json: bio_push
    end

    render status: 422, head: nil
  end

  def push
    if params[:request_id] != nil
      bio_push = BioPush.find_or_create_by(request_id: params[:request_id])
    else
      bio_push = BioPush.create
    end
    # render status: 200, json: bio_push
    if bio_push.confirmed_at.nil?
      render plain: "#{bio_push.request_id},0"
    else
      render plain: "#{bio_push.request_id},1"
    end
  end

  def confirm
    if params[:request_id] != nil
      bio_push = BioPush.find_or_create_by(request_id: params[:request_id])
    else
      bio_push = BioPush.create
    end
    bio_push.confirmed_at = Time.now
    bio_push.save
    # render status: 200, json: bio_push
    if bio_push.confirmed_at.nil?
      render plain: "#{bio_push.request_id},0"
    else
      render plain: "#{bio_push.request_id},1"
    end
  end

  def confirm_all
    bio_pushes = BioPush.where(confirmed_at: nil)
    bio_pushes.each do |bio_push|
      bio_push.confirmed_at = Time.now
      bio_push.save
    end
    render status: 200, json: bio_pushes
  end

  def cancel_all
    bio_pushes = BioPush.where.not(confirmed_at: nil)
    bio_pushes.each do |bio_push|
      bio_push.confirmed_at = nil
      bio_push.save
    end
    render status: 200, json: bio_pushes
  end

  def cancel
    if params[:request_id] != nil
      bio_push = BioPush.find_or_create_by(request_id: params[:request_id])
    else
      bio_push = BioPush.create
    end
    bio_push.confirmed_at = nil
    bio_push.save
    # render status: 200, json: bio_push
    if bio_push.confirmed_at.nil?
      render plain: "#{bio_push.request_id},0"
    else
      render plain: "#{bio_push.request_id},1"
    end
  end

  def bio_push_params
    params.require(:bio_push).permit(:request_id, :confirmed_at)
  end
end
