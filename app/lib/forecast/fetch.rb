module Forecast
  class Fetch < ApplicationServiceObject
    attribute :location, :string

    validates :location, presence: true

    DAYS = 3

    def call!
      validate!

      response = WeatherApi.forecast(location, days: DAYS)

      location_hash = response['location']
        .slice(*%w[name region country])
        .symbolize_keys

      current = response['current']
      forecast = response['forecast']

require 'debug'; debugger
      []
    end
  end
end
