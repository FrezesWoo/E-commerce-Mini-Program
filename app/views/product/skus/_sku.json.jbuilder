json.extract! sku, :id, :price, :product_id, :shipping_price, :currency, :description, :composition, :created_at, :updated_at
json.url sku_url(sku, format: :json)
