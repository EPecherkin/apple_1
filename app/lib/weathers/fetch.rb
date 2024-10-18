module Weathers
  class Fetch < ApplicationServiceObject
    attribute :name, :string
    attribute :region, :string
    attribute :country, :string

    validates :name, presence: true

    DAYS = 3

    def call!
      validate!

      if weather_cached?
        return [ location.weather, location, true ]
      end

      location_hash, current, forecast = fetch_location_and_weather

      actualize_location!(location_hash)
      actualize_weather!(current, forecast)

      [ location.weather, location, false ]
    end

    private

    def location
      return @location if defined?(@location)
      @location = Location.find_by(**{ name:, region:, country: }.compact)
    end

    def weather_cached?
      location && location.weather&.actual?
    end

    def fetch_location_and_weather
      query = if location
        LocationDecorator.new(location).view
      else
        [ name, region, country ].compact.join(",")
      end

      response = WeatherApi.forecast(query, days: DAYS)

      location_hash = response["location"]
        .slice(*%w[name region country])

      current = response["current"]
      forecast = response["forecast"]["forecastday"]

      return [location_hash, current, forecast]
    end

    def actualize_location!(location_hash)
      if !location
        @location = Location.create!(**location_hash)
      elsif location.attributes.slice(*%w[name region country]) != location_hash
        location.update!(**location_hash)
      end
    end

    def actualize_weather!(current, forecast)
      if location.weather
        location.weather.update!(current:, forecast:)
      else
        location.weather = Weather.create!(location:, current:, forecast:)
      end
    end
  end
end
