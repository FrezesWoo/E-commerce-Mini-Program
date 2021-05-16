json.extract! product_bundle, :id, :name, :condition, :price, :price_condition, :product_sku_id, :created_at, :updated_at
json.url product_bundle_url(product_bundle, format: :json)
