class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  belongs_to :user_role, class_name: "::User::Role", foreign_key: 'user_role_id'

  before_create :set_default_role

  def is_admin
     user_role.name == 'admin'
  end

  def is_editor
    ['admin', 'editor'].include?user_role.name
  end

  def is?(role_name)
    user_role.name == role_name
  end

  private

  def set_default_role
    if user_role.nil?
      self.user_role_id = User::Role.where(name: 'user').map { |item| item.id }
    end
  end
end
