class ApplicationServiceObject
  include ActiveModel::API
  include ActiveModel::Attributes
  include ActiveModel::Validations

  def call!
    raise NotImplementedError, "You should implement #{self.class.name}#call! method"
  end
end
