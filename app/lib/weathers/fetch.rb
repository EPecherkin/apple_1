module Weathers
  class Fetch < ApplicationServiceObject
    attribute :name, :string
    attribute :region, :string
    attribute :country, :string

    validates :name, presence: true

    DAYS = 3

    def call!
      validate!

      location = Location.find_by(**{name:, region:, country:}.compact)

      if location && location.weather&.actual?
        return [location.weather, location]
      end

      query = if location
        LocationDecorator.new(location).view
      else
        [name, region, country].compact.join(',')
      end

      response = WeatherApi.forecast(query, days: DAYS)

      location_hash = response['location']
        .slice(*%w[name region country])

      if !location
        location = Location.create!(name:, region:, country:)
      elsif location.attributes.slice(*%w[name region country]) != location_hash
        location.update!(**location_hash)
      end

      current = response['current']
      forecast = response['forecast']['forecastday']

      weather = if location.weather
        location.weather.update!(current:, forecast:)
        location.weather
      else
        Weather.create!(location:, current:, forecast:)
      end

      [weather, location]
    end
  end
end
