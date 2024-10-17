class WeatherApi
  include HTTParty
  base_uri 'https://api.weatherapi.com'

  KEY = ENV.fetch('WEATHERAPI_KEY')

  class << self
    def forecast(location, days: 1, aqi: false, alerts: false)
      query = {
        days:,
        q: location,
        key: KEY,
        aqi: aqi ? 'yes' : 'no',
        alerts: alerts ? 'yes' : 'no'
      }
      get('/v1/forecast.json', { query: })
    end
  end
end
