module Weathers
  class Fetch < ApplicationServiceObject
    attribute :name, :string
    attribute :region, :string
    attribute :country, :string

    validates :name, presence: true, length: { minimum: 2, maximum: MAX_NAME_LEN }
    validates :region, allow_blank: true, length: { minimum: 2, maximum: MAX_NAME_LEN }
    validates :country, allow_blank: true, length: { minimum: 2, maximum: MAX_NAME_LEN }

    MAX_NAME_LEN = 100
    DAYS = 7

    def call!
      validate!

      # Weather is cached for 30 minutes and automatically cleaned by DB
      if location&.weather
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

    def fetch_location_and_weather
      query = if location
        LocationDecorator.new(location).view
      else
        [ name, region, country ].compact.join(",")
      end

      response = WeatherApi.forecast(query, days: DAYS)

      location_hash = response["location"]
        .slice(*%w[name region country]).select { |_, v| v.present? }

      current = response["current"]
      forecast = response["forecast"]["forecastday"]

      [ location_hash, current, forecast ]
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
