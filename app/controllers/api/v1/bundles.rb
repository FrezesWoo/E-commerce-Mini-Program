module API
  module V1
    class Bundles < Grape::API
      include API::V1::Defaults
      resource :bundles do

        desc "Show all bundles", {
          headers: {
            "Platform" => {
              description: "Platform from Wechat Mp or Douyin Mp",
            },
            "Authorization" => {
              description: "Validates your identity",
              required: true
            }
          }
        }
        params do
          optional :conditional_price, type: String, desc: "Price of the order"
          optional :product_sku_ids, type: String, desc: "Ids of the product sku"
          optional :customer_id, type: String, desc: "ID of the customer"
        end
        get "", serializer: API::Serializers::Product::Bundles do
          current_user!(permitted_params[:customer_id])
          customer = is_platform?('douyin') ? ::DouyinCustomer.find(permitted_params[:customer_id]) : ::Customer.find(permitted_params[:customer_id])
          bundles = ::Product::Bundle.where(status: true).all
          # for price bundle
          bundles = bundles.where.not(condition: 0) if permitted_params[:conditional_price].blank? || permitted_params[:product_sku_ids].blank?
          bundles = bundles.where.not(id: ::Product::Bundle.filter_bundle_sku_ids(permitted_params[:product_sku_ids], 0, permitted_params[:conditional_price], platform)) if permitted_params[:conditional_price] && permitted_params[:product_sku_ids]
          # validate first order customer
          bundles = bundles.where('condition <> ?', 2) if customer.orders.where("status <> ?", 8).count > 0
          # validate && filter single sku gift
          bundles = bundles.where('condition <> ?', 5) if permitted_params[:product_sku_ids].blank?
          bundles = bundles.where.not(id: ::Product::Bundle.filter_bundle_sku_ids(permitted_params[:product_sku_ids], 5, nil, platform)) if !permitted_params[:product_sku_ids].blank?
          # filter the bundles product skus that are not in stock
          quantity_condition = is_platform?('douyin') ? "product_skus.douyin_quantity > ?" : "product_skus.quantity > ?"
          bundles = bundles.eager_load(product_bundles_product_skus: [:product_sku]).where(quantity_condition, 0)
          bundles = bundles.select { |bundle| bundle.validate_available_bundle(platform) }

          bundles
        end

      end
    end
  end
end
