class AddWechatSessionKeyToCustomers < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :wechat_session_key, :string
  end
end
