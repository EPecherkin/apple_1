class WeathersController < ApplicationController
  def index
    location_query = params[:l]&.strip

    if location_query.present?
      location_data = LocationDecorator.parse(location_query)
      @weather, location, cached = Weathers::Fetch.new(**location_data).call!
      @location = LocationDecorator.new(location)

      if cached
        flash.notice = "CACHED"
      end
    end
  end

  def search
    term = params[:term]
    if !term || term.length > Weathers::Fetch::MAX_NAME_LEN
      render json: []
      return
    end

    parts = term.split(/\ |,/).compact

    regex = /#{parts.join('|')}/i

    locations = Location
      .any_of({ name: regex }, { region: regex }, { country: regex })
      .order_by(name: :asc, region: :asc, coyntry: :asc)
    result = locations.map { |l| LocationDecorator.new(l) }.map(&:to_json)

    render json: { result: }
  end
end
