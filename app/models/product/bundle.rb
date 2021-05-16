class Product::Bundle < ApplicationRecord
  include SetCurrentUser

  belongs_to :created_by, class_name: :User
  belongs_to :updated_by, class_name: :User
  belongs_to :product, class_name: '::Product', foreign_key: 'product_id', optional: true
  has_many :product_bundles_product_skus, class_name: '::Product::BundlesProductSku', foreign_key: 'product_bundle_id', dependent: :destroy
  has_many :product_bundles_gift_skus, class_name: '::Product::BundlesGiftSku', foreign_key: 'product_bundle_id', dependent: :destroy

  translates :name

  enum condition: { price: 0, product: 1, gift: 2, giveaway:3, freebie:4, skugift:5 }

  after_save :update_product_bundles_gift_skus

  accepts_nested_attributes_for :product_bundles_product_skus, :product_bundles_gift_skus, allow_destroy: true

  def update_product_bundles_gift_skus
    product_bundles_gift_skus.destroy_all() if condition != 'price' && condition != 'skugift'
  end

  def validate_available_bundle(source)
    product_bundles_product_skus.map { |sku| sku.validate_available_quantity(source) }
  end

  def validtae_empty_sku(source)
    product_bundles_product_skus.each do |sku|
      quantity = source == "wechat" ? sku.product_sku&.available_quantity : sku.product_sku&.available_douyin_quantity
      return false if quantity > 0
    end

    true
  end

  def self.filter_bundle_sku_ids(product_skus, condition, price, source)
    bundles = ::Product::Bundle.eager_load(:product_bundles_gift_skus).where(status: true).where(condition: condition)

    # set product skus params
    product_bundle_skus = product_skus.split(',')
    product_bundle_sku_ids = Array.new()
    product_bundle_skus.map { |sku| product_bundle_sku_ids.push(sku.split(':').first.to_i) }

    # for skugift bundle
    if condition === 5
      ids = bundles.where('product_bundles_gift_skus.product_sku_id IN (?)', product_bundle_sku_ids).pluck(:id)
      return ids.count === 0 ? bundles.pluck(:id) : bundles.where.not(id: ids).pluck(:id)
    end
    # for price  bundle
    if condition === 0
      bundle = bundles.where('price_condition <= ?', price).order(price_condition: :desc)

      bundle.each do |product_bundle|
        next if product_bundle.validtae_empty_sku(source)
        return bundles.where.not(id: product_bundle.id).pluck(:id) if product_bundle.product_bundles_gift_skus.count === 0
        # get intersection
        intersect_ids = product_bundle_sku_ids & product_bundle.product_bundles_gift_skus.pluck(:product_sku_id)
        next if intersect_ids.count === 0
        # get gift sku sum price
        gift_sku_price = 0
        product_bundle_skus.each do |sku|
          if intersect_ids.include?(sku.split(':').first.to_i)
            product_sku = Product::Sku.find(sku.split(':').first.to_i)
            next if product_sku.nil?
            gift_sku_price += product_sku.price * sku.split(':').second.to_i
          end
        end
        return bundles.where.not(id: product_bundle.id).pluck(:id) if gift_sku_price >= product_bundle.price_condition

      end

      return bundles.pluck(:id)
    end

  end

end
