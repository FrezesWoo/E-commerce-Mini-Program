module API
  module V1
    class Products < Grape::API
      include API::V1::Defaults

      resource :products do

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
          optional :number, type: Integer, desc: "Number of articles per page"
          optional :is_star_product, type: Boolean, desc: "Only want product start"
        end
        get "", serializer: API::Serializers::Products do
          authenticate!
          products = ::Product.eager_load(:translations, product_category: :translations, product_skus: :translations).all.order(ordering: :asc)
          products = products.paginate(:per_page=>permitted_params[:number] || 20,:page=>permitted_params[:page]) if permitted_params[:page]
          products = products.where(star_product: true) if permitted_params[:is_star_product]
          products
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
          requires :id, type: String, desc: "id of the product"
        end
        get ":id" do
          authenticate!
          product = ::Product.eager_load(:translations, product_category: :translations, product_skus: :translations).find(permitted_params[:id])
          present product, with: API::Entities::Products
          product
        end

        desc "Generate QR code for product detail", {
          nickname: 'Lot Qr code',
          headers: {
            "Authorization" => {
              description: "Validates your identity",
              required: true
            }
          }
        }
        params do
          optional :params, type: String, desc: "Params to pass to the page"
        end
        post ":id/qr-code" do
          authenticate!
          wechat = ::WechatTool::Mp.new()
          qr_code = wechat.generate_qr_code_unlimited('pages/product/index', permitted_params[:params])
          return { result:  'data:image/png;base64,' + Base64.strict_encode64(qr_code.to_s.force_encoding('utf-8').encode) }
        end

        desc "Show product skus by product id"
        params do
          requires :id, type: String, desc: "id of the product"
        end
        get ":id/skus", serializer: API::Serializers::ProductProductSkus do
          skus = ::Product::Sku.eager_load(:translations).where(product_id: permitted_params[:id])
          skus
        end

      end
    end
  end
end
