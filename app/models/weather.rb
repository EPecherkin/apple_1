class Weather
  include Mongoid::Document
  include Mongoid::Timestamps

  field :current, type: Hash
  field :forecast, type: Array

  belongs_to :location

  CACHE_DURATION = 30.minutes

  # MongoDB feature to automatically clean expired documents
  index({ created_at: 1 }, { expire_after_seconds: CACHE_DURATION })
end
