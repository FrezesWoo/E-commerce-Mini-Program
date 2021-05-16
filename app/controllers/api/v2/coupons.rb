module API
  module V2
    class Coupons < Grape::API
      include API::V2::Defaults

      resource :coupons do

        desc "Return the coupon data", {
            headers: {
                "Authorization" => {
                    description: "Validates your identity",
                    required: true
                }
            }
        }
        params do
          requires :customer_id, type: String, desc: "ID of the customer"
          requires :code, type: String, desc: "Code of the coupon"
          requires :product_skus, type: Array do
            requires :product_sku_id, type: Integer, desc: "Id of the sku"
            requires :quantity, type: Integer, desc: "Quantity of the sku"
          end
        end
        post ":customer_id/code/:code" do
          current_user!(permitted_params[:customer_id])
          coupon = ::Coupon.where(code: permitted_params[:code]).first!
          # validate is valid
          if !coupon || coupon.status != 'coupon_valid'
            status 206
            return { :status_code => env['api.endpoint'].status, :response_type => 'error', :details => "#{I18n.t('coupons.invalid_coupon')}" }
          end
          # validate is expires
          now = Time.now.strftime("%Y-%m-%d %H:%M:%S")
          if !now.between?(coupon.expiry_start_date.to_s,coupon.expiry_end_date.to_s)
            status 206
            return { :status_code => env['api.endpoint'].status, :response_type => 'error', :details => "#{I18n.t('coupons.invalid_coupon')}" }
          end
          # validate is disposable
          if coupon.is_disposable && !coupon.validate_disposable(false)
            status 206
            return { :status_code => env['api.endpoint'].status, :response_type => 'error', :details => "#{I18n.t('coupons.used_coupon')}" }
          end
          # validate coupon price_condition or product_condition
          if coupon.validate_condition(permitted_params[:product_skus])
            status 206
            details = "#{I18n.t('coupons.coupon_price_limit')}" if coupon.condition == 'price'
            details = "#{I18n.t('coupons.coupon_product_limit')}" if coupon.condition == 'product'
            return { :status_code => env['api.endpoint'].status, :response_type => 'error', :details => details }
          end

          present coupon, with: API::Entities::Coupons
          coupon
        end

      end
    end
  end
end
