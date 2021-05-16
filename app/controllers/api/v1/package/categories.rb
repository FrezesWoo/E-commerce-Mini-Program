module API
  module V1
    module Package
      class Categories < Grape::API
        include API::V1::Defaults

        format :json

        resource :'package-categories' do

          desc "Show all product packages",
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
          # get "", serializer: API::Serializers::Product::Package::Categories do
          get "" do
            authenticate!
            # package_categories = ::Product::Category.eager_load(:translations, product_packages: [:translations, product_category: :translations]).all.order(ordering: :asc)
            # package_categories = package_categories.where(is_sample: false)
            # package_categories = package_categories.where(publish: true) if get_compatible_template('package_category_publish')
            # package_categories
            result = Rails.cache.fetch("package_categories", expires_in: 3200) do
              product_categories = ::Product::Category.eager_load(:product_packages).where("product_packages.publish = ? AND product_packages.hidden_product != ?", true, true).all.order(ordering: :asc)
              product_categories = product_categories.where(publish: true).where(is_sample: false)
              (product_categories.map{|product_category| API::Serializers::Product::Package::Categories.new(product_category)}).to_json
            end
            { result: JSON.parse(result) }
          end

          desc "Show one specific packages",
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
            requires :id, type: String, desc: "id of the package category"
          end
          get ":id" do
            authenticate!
            package_category = ::Product::Category.left_joins(:translations).eager_load(product_packages: [:translations, product_category: :translations]).find(permitted_params[:id])
            present package_category, with: API::Entities::Product::Package::Categories
            package_category
          end

        end
      end
    end
  end
end
