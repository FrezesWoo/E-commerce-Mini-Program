class AddBirthdayToCustomers < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :birthday, :datetime
  end
end
