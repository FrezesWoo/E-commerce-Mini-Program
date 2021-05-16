class RenameRoles < ActiveRecord::Migration[5.2]
  def change
    rename_table :roles, :user_roles
    drop_table :roles_users
  end
end
