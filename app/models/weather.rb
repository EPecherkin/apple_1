class Weather
  include Mongoid::Document
  include Mongoid::Timestamps

  field :current, type: Hash
  field :forecast, type: Array

  belongs_to :location

  CACHE_DURATION = 30.minutes

  def actual?
    updated_at < 30.minutes.ago
  end
end
