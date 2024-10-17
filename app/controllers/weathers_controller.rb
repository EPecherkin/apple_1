class WeathersController < ApplicationController
  def index
    @location = params[:location]

    @locations = Location.all

    if @location
      @weathers = Weathers::Fetch.new(location: @location).call!
    end
  end
end
