class WeathersController < ApplicationController
  def index
    location_query = params[:l]&.strip

    if location_query.present?
      location_data = LocationDecorator.parse(location_query)
      @weather, location = Weathers::Fetch.new(**location_data).call!

      proper_location_query = LocationDecorator.new(location).query
      if location_query != proper_location_query
        redirect_to root_path(l: proper_location_query)
        return
      end
    end

    @location_query = location_query
    @locations = Location.all.map do |loc|
      LocationDecorator.new(loc)
    end
  end
end
