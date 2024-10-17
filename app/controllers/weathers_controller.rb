class WeathersController < ApplicationController
  def index
    @location = params[:location]

    if @location
      @forecast = Forecast::Fetch.new(location: @location).call!
    end
  end
end
