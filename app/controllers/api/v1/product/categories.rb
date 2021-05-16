module API
  module V1
    module Product
      class Categories < Grape::API
        include API::V1::Defaults

        format :json

        resource :'product-categories' do

          desc "Show all products",
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
            optional :with_sample, type: String, desc: "see list of category with samples or not"
          end
          # get "", serializer: API::Serializers::Product::Categories do
          get "" do
            authenticate!
            # product_categories = ::Product::Category.eager_load(:translations, products: [:translations, product_category: :translations, product_skus: :translations]).all.order(ordering: :asc)
            # product_categories = product_categories.where(is_sample: false) if !permitted_params[:with_sample]
            # product_categories
            result = Rails.cache.fetch("product_categories", expires_in: 3200) do
              product_categories = ::Product::Category.all.order(ordering: :asc)
              product_categories = product_categories.where(is_sample: false) if !permitted_params[:with_sample]
              (product_categories.map{|product_category| API::Serializers::Product::Categories.new(product_category)}).to_json
            end
            { result: JSON.parse(result) }
          end

          desc "Show one specific products",
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
            requires :id, type: String, desc: "id of the product category"
          end
          get ":id" do
            authenticate!
            product_category = ::Product::Category.left_joins(:translations).eager_load(products: [:translations, product_category: :translations, product_skus: :translations]).find(permitted_params[:id])
            present product_category, with: API::Entities::Product::Categories
            product_category
          end

        end
      end
    end
  end
end
