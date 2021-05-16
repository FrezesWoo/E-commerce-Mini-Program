json.extract! order, :id, :customer_id, :order_number, :status, :address_id, :amount, :created_at, :updated_at
json.url order_url(order, format: :json)
