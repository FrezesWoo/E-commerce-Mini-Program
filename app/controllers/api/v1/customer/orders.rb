module API
  module V1
    module Customer
      class Orders < Grape::API
        include API::V1::Defaults
        use ActionDispatch::RemoteIp

        resource :customers do

          desc "Return all orders for customer", {
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
            requires :id, type: String, desc: "ID of the customer"
            optional :item_per_page, type: Integer, desc: "Number of Items"
            optional :page_nb, type: Integer, desc: "Page number"
          end
          get ":id/orders", serializer: API::Serializers::Orders do
            current_user!(permitted_params[:id])
            page_nb = permitted_params[:page_nb].nil? ? 1 : permitted_params[:page_nb]
            item_per_page = permitted_params[:item_per_page].nil? ? 50 : permitted_params[:item_per_page]
            orders = is_platform?('douyin') ? ::Order.eager_load(:douyin_customer).where(douyin_customer_id: permitted_params[:id]) : ::Order.eager_load(:customer).where(customer_id: permitted_params[:id])
            header 'X-ELEMENT-NB', orders.count
            orders.paginate(:per_page=>item_per_page,:page=>page_nb)
            orders
          end

          desc "Return a specific order for given customes", {
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
            requires :customer_id, type: Integer, desc: "ID of the order"
            requires :order_id, type: Integer, desc: "ID of the order"
          end
          get ":customer_id/orders/:order_id" do
            current_user!(permitted_params[:customer_id])
            order = ::Order.where(id: permitted_params[:order_id]).first
            order_customer_id = is_platform?('douyin') ? order.douyin_customer_id : order.customer_id
            if !order || order_customer_id != permitted_params[:customer_id]
              status 203
              return { :status_code => env['api.endpoint'].status, :response_type => 'error', :details => 'Unauthorized. Illegal Operation.' }
            end
            present order, with: API::Entities::Orders, platform: platform
            order
          end

          desc "Validate Customer Order Sku Quantity Is Out Of Stock", {
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
            requires :customer_id, type: Integer, desc: "ID of the order"
            requires :order_id, type: String, desc: "ID of the order"
          end
          get ":customer_id/orders/:order_id/sku-quantity" do
            current_user!(permitted_params[:customer_id])
            order = ::Order.where(id: permitted_params[:order_id]).first!
            #validate customer
            order_customer_id = is_platform?('douyin') ? order.douyin_customer_id : order.customer_id
            if permitted_params[:customer_id] != order_customer_id
              status 206
              return { :status_code => env['api.endpoint'].status, :response_type => 'error', :details => 'Unauthorized. Illegal Operation.' }
            end
            order.validate_sku_quantity
          end

          desc "Update a customer order", {
            headers: {
              "Authorization" => {
                description: "Validates your identity",
                required: true
              }
            }
          }
          params do
            requires :open_id, type: String, desc: "Opend Id of the customer"
            requires :order_bn, type: String, desc: "ID of the order"
            requires :status, type: String, desc: "New status of the order"
            requires :logi_no, type: String, desc: "Shipping number"
            # requires :item_info, type: Array do
            #   requires :bn, type: String, desc: "product SKU"
            #   requires :num, type: Integer, desc: "Product quantity"
            #   requires :logi_no, type: String, desc: "Shipping number"
            #   requires :logi_name, type: String, desc: "Shipping number"
            # end
          end
          put ":open_id/orders/:order_number", requirements: { open_id: /.*/ } do
            authentify_oms!
            order_customer = oms_source?('shiseido_mp') ? :customer : :douyin_customer
            order = ::Order.eager_load(order_customer).where('order_number = ? AND open_id = ?', permitted_params[:order_bn],  permitted_params[:open_id]).first!
            order.status = permitted_params[:status]
            order.save
            order.update_skus(permitted_params[:logi_no])
            order.send_notification
            if order
              status 201
              return { :status_code => env['api.endpoint'].status, :response_type => 'success', :details => 'order successfully updated.' }
            end
          end

          desc "Delete an order", {
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
            requires :customer_id, type: Integer, desc: "ID of the customer"
            requires :order_id, type: Integer, desc: "ID of the order"
          end
          delete ":customer_id/orders/:order_id" do
            current_user!(permitted_params[:customer_id])
            order = ::Order.where(id: permitted_params[:order_id]).first!
            order_customer_id = is_platform?('douyin') ? order.douyin_customer_id : order.customer_id
            if order.status != 'unpaid' || order_customer_id != permitted_params[:customer_id]
              status 206
              return { :status_code => env['api.endpoint'].status, :response_type => 'error', :details => 'Unauthorized. Illegal Operation.' }
            end
            order.destroy if order.status == 'unpaid'
          end

          desc "Create an order", {
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
            requires :customer_id, type: String, desc: "Id of the wechat customer or the douyin customer"
            requires :address, type: String, desc: "Address the customer"
            requires :province, type: String, desc: "Province of the customer"
            requires :city, type: String, desc: "City the customer"
            requires :area, type: String, desc: "Area the customer"
            requires :mobile, type: String, desc: "Phone the customer"
            requires :name, type: String, desc: "Name the customer"
            requires :need_trial, type: Boolean, desc: "Need Post On Trail"
            requires :order_skus_attributes, type: Array do
              requires :product_sku_id, type: Integer, desc: "product id"
              requires :quantity, type: Integer, desc: "product quantity"
            end
            requires :need_invoice, type: Boolean, desc: "Phone the customer"
            optional :zip, type: String, desc: "ZIP the customer"
            optional :tax_number, type: String, desc: "Tax number of the customer"
            optional :invoice_title, type: String, desc: "title of the invoice"
            optional :email, type: String, desc: "email of the invoice"
            optional :order_bundles_attributes, type: Array do
              requires :product_bundle_id, type: Integer, desc: 'Id of the bundle'
              requires :product_sku_id, type: Integer, desc: 'Id of the sku'
              requires :quantity, type: Integer, desc: "Quantity of the sku"
            end
            optional :has_gift_message, type: String, desc: "Has gift message or not"
            optional :gift_card_attributes, type: Hash do
              requires :to, type: String, desc: "Gift to user"
              requires :content, type: String, desc: "Gift message"
              requires :from, type: String, desc: "Gift from user"
              requires :gift_card_id, type: Integer, desc: "Gift card id"
            end
            optional :order_packages_attributes, type: Array, allow_blank: false do
              requires :product_package_id, type: Integer, desc: "Id of the product package"
              requires :quantity, type: Integer, desc: "Quantity of the product package"
              requires :product_package_skus_attributes, type: Array do
                requires :product_sku_id, type: Integer, desc: "Id of the product sku"
                requires :quantity, type: Integer, desc: "Quantity of the product sku"
              end
            end
            optional :order_coupons_attributes, type: Array do
              requires :coupon_id, type: Integer, desc: 'Id of the coupon'
              requires :product_sku_id, type: Integer, desc: 'Id of the sku'
              requires :quantity, type: Integer, desc: "Quantity of the sku"
            end
          end
          post ":customer_id/orders" do
            # add args manual
            permitted_params[:douyin_customer_id] = permitted_params[:customer_id] if is_platform?('douyin')
            permitted_params[:source] = is_platform?('douyin') ? 'douyin' : 'wechat'
            current_user!(permitted_params[:customer_id])
            # validate CRM customer number is removed
            customer = is_platform?('douyin') ? ::DouyinCustomer.find(permitted_params[:douyin_customer_id]) : ::Customer.find(permitted_params[:customer_id])
            if !customer || customer.crm_member_no.nil? || customer.validate_crm_removed(platform)
              status 207
              return { status_code: env['api.endpoint'].status, response_type: 'error', details: 'This crm customer is already removed.'}
            end
            # validate bundles params repeat
            # permitted_params['order_bundles_attributes'] = order_bundles.uniq
            order_bundles = permitted_params['order_bundles_attributes']
            if !order_bundles.blank? && order_bundles.count != order_bundles.uniq.count
              status 202
              return { status_code: env['api.endpoint'].status, response_type: 'error', details: 'Order bundles params error.'}
            end
            # errors from order models
            order = is_platform?('douyin') ? ::Order.create(permitted_params.except(:customer_id)) : ::Order.create(permitted_params)
            if !order.errors.messages.empty?
              !order.errors.messages[:"order_packages.product_package_skus.product_sku_limit"].empty? ? (status 206) : (status 202)
              return {:status_code => env['api.endpoint'].status, :response_type => 'error', :details => order.errors.messages.to_s}
            end
            present order, with: API::Entities::Orders, platform: platform
            order
          end

          desc "Order payments", {
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
            requires :customer_id, type: Integer, desc: "Id of the customer"
            requires :order_id, type: String, desc: "Id the order"
          end
          post ":customer_id/orders/:order_id/payments" do
            current_user!(permitted_params[:customer_id])
            order = ::Order.find(permitted_params[:order_id])
            order_customer_id = is_platform?('douyin') ? order.douyin_customer_id : order.customer_id
            if order.status != 'unpaid' || order_customer_id != permitted_params[:customer_id]
              status 206
              return { :status_code => env['api.endpoint'].status, :response_type => 'error', :details => 'Unauthorized. Illegal Operation.' }
            end
            if !order.validate_sku_quantity
              status 206
              return { :status_code => env['api.endpoint'].status, :response_type => 'error', :details => 'Order sku is out of stock.' }
            end
            if !order.validate_order_payments.nil?
              status 202
              return { :status_code => env['api.endpoint'].status, :response_type => 'error', :details => order.validate_order_payments }
            end
            ip = request && request.env['HTTP_X_FORWARDED_FOR'].split(',').first
            is_platform?('douyin') ? order.generate_douyin_payment(ip) : order.generate_wechat_payment
          end

          desc "Return an order", {
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
            requires :order_number, type: String, desc: "Number of the order"
            requires :customer_id, type: String, desc: "ID of the customer"
          end
          get ":customer_id/orders/:order_number/tracking" do
            current_user!(permitted_params[:customer_id])
            query = ::OmsD::OmsQuery.new()
            order = ::Order.where(order_number: permitted_params[:order_number]).first!
            shipping_numbers = order.order_logistics.map(&:shipping_number)
            req = query.get_tracking({logi_no: shipping_numbers}, order.source)
            req
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
            requires :package_id, type: String, desc: "ID of the package"
          end
          get ":customer_id/validate_sample/:package_id" do
            current_user!(permitted_params[:customer_id])
            ::Product::Package.validate_sample(false, permitted_params[:package_id], permitted_params[:customer_id], platform)
          end

          desc "Tencent Marketing User Actions Add", {
              headers: {
                  "Authorization" => {
                      description: "Validates your identity",
                      required: true
                  }
              }
          }
          params do
            requires :click_id, type: String, desc: "The tencent marketing click id"
            requires :amount, type: String, desc: "Amount of the order"
            requires :url, type: String, desc: "Url of the order"
          end
          post "/user_actions_add" do
            authenticate!
            wechat = ::WechatTool::Mp.new()
            wechat.user_actions_add(permitted_params[:click_id], permitted_params[:amount], permitted_params[:url])
          end

        end

      end
    end
  end
end
