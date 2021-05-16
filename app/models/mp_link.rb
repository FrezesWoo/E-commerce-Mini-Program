class MpLink < ApplicationRecord
  validates :path, :name, presence: true
end
