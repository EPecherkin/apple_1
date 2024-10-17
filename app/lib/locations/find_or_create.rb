module Locations
  class FindOrCreate < ApplicationServiceObject
    attribute :name, :string
    attribute :region, :string
    attribute :country, :string

    validates :name, presence: true
    validates :country, presence: true

    def call!
      validate!

      location = if region == nil
        Location.find_by(name:, country:)
      else
        Location.find_by(name:, region:, country:)
      end

      location ||= Location.create(name:, region:, country:)

      location
    end
  end
end
