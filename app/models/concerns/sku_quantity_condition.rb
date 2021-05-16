module SkuQuantityCondition
  extend ActiveSupport::Concern

  def sku_quantity_condition(source)
    source == "wechat" ? (!product_sku&.available_quantity || quantity > product_sku&.available_quantity) :
        (!product_sku&.available_douyin_quantity || quantity > product_sku&.available_douyin_quantity)
  end
end