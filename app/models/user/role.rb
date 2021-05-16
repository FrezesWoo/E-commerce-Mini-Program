class User::Role < ApplicationRecord
  has_many :user, class_name: "::User", foreign_key: 'role_id'
end
