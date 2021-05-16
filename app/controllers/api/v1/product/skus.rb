module API
  module V1
    module Product
      class Skus < Grape::API
        include API::V1::Defaults

        format :json

        resource :'product-skus' do

          desc "Show all products skus",
          {
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
          get "", serializer: API::Serializers::Product::Skus, root: :'product-skus' do
            authenticate!
            skus = ::Product::Sku.eager_load(:translations, :attachments, product: [:translations, product_category: :translations]).all
            skus
          end

          desc "Show one specific product sku",
          {
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
            requires :id, type: String, desc: "id of the product sku"
          end
          get ":id", root: :'product-skus' do
            authenticate!
            sku = ::Product::Sku.left_joins(:translations).eager_load(:attachments, product: [:translations, product_category: :translations]).find(permitted_params[:id])
            present sku, with: API::Entities::Product::Skus
            sku
          end

          desc "Mass sku update"
          params do
            requires :product_skus, type: Array do
              requires :sku, type: String, desc: "sku of the product"
              requires :quantity, type: Integer, desc: "quantity of the sku"
            end
          end
          put "/bulk-update", root: :'product-skus' do
            authentify_oms!
            ::Product::Sku.mass_update(permitted_params[:product_skus], oms_source?('shiseido_mp'))
            SubscribePackageWorker.perform_in(3.seconds)
            status 201
            return { :status_code => env['api.endpoint'].status, :response_type => 'success', :details => 'product skus successfully updated.' }
          end

        end
      end
    end
  end
end
