class AddDefaultValueToIsSynced < ActiveRecord::Migration[5.2]
  def change
    change_column_default :orders, :is_synced, false
  end
end
