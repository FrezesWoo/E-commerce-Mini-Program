class AddFieldsToCampaign < ActiveRecord::Migration[5.2]
  def change
    add_column :campaigns, :page_type, :integer
    add_column :campaigns, :publish, :boolean
  end
end
