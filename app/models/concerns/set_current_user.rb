# app/models/concerns/log_validation_errors.rb
module SetCurrentUser
  extend ActiveSupport::Concern

  included do
    before_validation :set_default_creator
  end

  def set_default_creator
    if self.created_by.nil?
      self.created_by_id = self.updated_by_id
    end
  end
end
