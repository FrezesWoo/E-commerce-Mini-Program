module API
  module V1
    module Product
      class Packages < Grape::API
        include API::V1::Defaults

        format :json

        resource :'product-packages' do
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
            optional :page, type: Integer, desc: "Page number of the paginator"
            optional :number, type: Integer, desc: "Number of per page"
            optional :is_star_product, type: Boolean, desc: "Only want star product package"
          end
          get "", serializer: API::Serializers::Product::Packages do
            authenticate!
            packages = ::Product::Package.eager_load(:translations).where(publish: true).all.order(ordering: :asc)
            packages = packages.paginate(:per_page=>permitted_params[:number] || 20,:page=>permitted_params[:page]) if permitted_params[:page]
            packages = packages.where(star_product: true) if permitted_params[:is_star_product]
            packages
          end

          desc "Show one specific product packages",
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
            requires :id, type: String, desc: "id of the product package"
          end
          get ":id" do
            authenticate!
            package = ::Product::Package.eager_load(:translations, :product_package_products).find(permitted_params[:id])
            present package, with: API::Entities::Product::Packages
            package
          end

          desc "Generate QR code for product package detail", {
              nickname: 'Lot Qr code',
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
            optional :params, type: String, desc: "Params to pass to the page"
            requires :trail, type: Boolean, desc: "if is trail"
          end
          post ":id/qr-code" do
            authenticate!
            path = permitted_params[:trail] ? 'pages/free-sample/index' : 'pages/product/index'
            wechat = ::WechatTool::Mp.new()
            qr_code = wechat.generate_qr_code_unlimited(path, permitted_params[:params])
            return { result:  'data:image/png;base64,' + Base64.strict_encode64(qr_code.to_s.force_encoding('utf-8').encode) }
          end

          desc "Validate paid sample", {
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
            requires :customer_id, type: String, desc: "ID of the customer"
            requires :id, type: String, desc: "ID of the package"
          end
          post ":customer_id/subscribe/:id" do
            current_user!(permitted_params[:customer_id])
            package = ::Product::Package.find(permitted_params[:id])
            if !package || !package.product_category.is_sample || !package.need_subscribe
              status 206
              return { :status_code => env['api.endpoint'].status, :response_type => 'error', :details => 'Unauthorized. Illegal Operation.' }
            end
            # store data to psql
            package_subscription = PackageSubscription.where('product_package_id = ? AND customer_id = ?', permitted_params[:id], permitted_params[:customer_id]).first
            ::PackageSubscription.create(product_package_id: permitted_params[:id], customer_id: permitted_params[:customer_id]) if !package_subscription
          end

        end
      end
    end
  end
end
