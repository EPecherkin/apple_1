class Weather
  include Mongoid::Document
  include Mongoid::Timestamps

  field :current, type: Hash
  field :forecast, type: Hash
  belongs_to :location
end
