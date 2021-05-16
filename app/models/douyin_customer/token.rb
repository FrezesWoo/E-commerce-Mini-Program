class DouyinCustomer::Token < ApplicationRecord
  include TokenMethod
  belongs_to :douyin_customer

  before_create :random_token, :set_expire_at
end
