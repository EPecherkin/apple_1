class LocationDecorator
  attr_reader :location

  delegate :name, :region, :country, :created_at, :updated_at, to: :location

  def self.parse(location_query)
    parts = location_query.split(",").map(&:strip)
    {
      name: parts[0], # the first one is always the name
      region: parts.count == 3 ? parts[1] : nil, # region is there only if it is in the middle
      country: parts.count > 1 ? parts[-1] : nil # country is always the last one
    }.select { |_, v| v.present? }
  end

  def initialize(location)
    @location = location
  end

  def query
    [ location.name, location.region, location.country ].join(", ")
  end

  def view
    [ location.name, location.region, location.country ].compact.join(", ")
  end

  def to_json
    { query:, view: }
  end
end
