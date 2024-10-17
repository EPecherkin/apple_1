class IP
  include Mongoid::Document
  include Mongoid::Timestamps

  field :ip, type: String
  belongs_to :location
end
