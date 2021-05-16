class AddNeedTrialToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :need_trial, :boolean
  end
end
