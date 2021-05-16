class Product::Package::Product < ApplicationRecord
  belongs_to :product_package, class_name: '::Product::Package', foreign_key: 'product_package_id', optional: true
  belongs_to :product, class_name: '::Product', foreign_key: 'product_id', optional: true

  has_many :skus, class_name: "::Product::Package::Product::Sku", foreign_key: 'product_package_product_id', dependent: :destroy

  accepts_nested_attributes_for :skus, allow_destroy: true

  def validate_subscribe_condition
    num = 0
    skus.map { |sku| num += 1 if sku.product_sku.available_quantity <= 0 }

    return true if skus.count == num
    return false
  end
end
