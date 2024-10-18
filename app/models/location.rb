class Location
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :region, type: String
  field :country, type: String

  has_one :weather
end
