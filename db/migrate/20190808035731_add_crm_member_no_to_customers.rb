class AddCrmMemberNoToCustomers < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :crm_member_no, :string
  end
end
