json.extract! customer, :id, :gender, :name, :open_id, :union_id, :wechat_data, :email, :phone, :avatar, :created_at, :updated_at
json.url customer_url(customer, format: :json)
