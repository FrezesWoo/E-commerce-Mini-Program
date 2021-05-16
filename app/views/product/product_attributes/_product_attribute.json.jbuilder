json.extract! product_attribute, :id, :name, :value, :picture, :product_attribute_category_id, :created_at, :updated_at
json.url product_attribute_url(product_attribute, format: :json)
