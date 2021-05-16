json.extract! product, :id, :description, :name, :note, :composition, :product_category_id, :created_at, :updated_at
json.url product_url(product, format: :json)
