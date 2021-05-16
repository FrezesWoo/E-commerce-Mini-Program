class CreateDouyinCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :douyin_customers do |t|
      t.string :open_id, null: false
      t.string :union_id
      t.string :name
      t.integer :gender
      t.string :phone
      t.string :email
      t.datetime :birthday
      t.jsonb :douyin_data
      t.string :douyin_session_key
      t.string :crm_member_no
      t.boolean :agreed_marketing
      t.string :reference

      t.timestamps
    end

    add_index :douyin_customers, :open_id, unique: true
    add_index :douyin_customers, :union_id, unique: true
    add_index :douyin_customers, :phone, unique: true
  end
end
