class Customer::Token < ApplicationRecord
  include TokenMethod
  belongs_to :customer

  before_create :random_token, :set_expire_at
end
