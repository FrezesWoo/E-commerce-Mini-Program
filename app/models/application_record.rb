class ApplicationRecord < ActiveRecord::Base
  include LogValidationErrors
  self.abstract_class = true

  def self.number?(string)
    true if Float(string) rescue false
  end
end
