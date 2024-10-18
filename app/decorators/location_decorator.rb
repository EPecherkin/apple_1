class LocationDecorator
  attr_reader :location

  def self.parse(location_query)
    parts = location_query.split(',').map(&:strip)
    {
      name: parts[0],
      region: parts[1],
      country: parts[2],
    }.compact
  end

  def initialize(location)
    @location = location
  end

  def query
    [location.name, location.region, location.country].join(', ')
  end

  def view
    [location.name, location.region, location.country].compact.join(', ')
  end
end

