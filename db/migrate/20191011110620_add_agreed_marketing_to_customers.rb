class AddAgreedMarketingToCustomers < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :agreed_marketing, :boolean
  end
end
