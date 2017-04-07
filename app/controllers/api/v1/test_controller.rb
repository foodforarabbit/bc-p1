class Api::V1::TestController < ApplicationController

  def index
    render status: 200, json: "test"
  end

  def show
    render status: 200, json: params[:id]
  end

  def create
    render status: 200, json: "test"
  end

  def update
    render status: 200, json: params[:id]
  end

  def destroy
    render status: 200, json: params[:id]
  end
end
