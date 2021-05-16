module API
  module V1
    class Customers < Grape::API
      include API::V1::Defaults
      use ActionDispatch::RemoteIp

      resource :customers do
        desc "Return ip address"
        get "get-ip-address" do
          request && request.env['HTTP_X_FORWARDED_FOR'].split(',').first
        end

        desc "Return a customer", {
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
        end
        get ":id" do
          current_user!(permitted_params[:id])
          customer = is_platform?('douyin') ? ::DouyinCustomer.find(permitted_params[:id]) : ::Customer.find(permitted_params[:id])
          present customer, with: is_platform?('douyin') ? API::Entities::DouyinCustomers : API::Entities::Customers
          customer
        end

        desc "Create a customer", {
            headers: {
                "Platform" => {
                    description: "Platform from Wechat Mp or Douyin Mp",
                }
            }
        }
        params do
          requires :wechat_token, type: String, desc: "Wechat or Douyin token of the customer"
        end
        post "" do
          customer = is_platform?('douyin') ? ::DouyinCustomer.douyin_silent_login(permitted_params['wechat_token']) : ::Customer.wechat_silent_login(permitted_params['wechat_token'])
          customer.login!
          present customer, with: is_platform?('douyin') ? API::Entities::DouyinCustomers : API::Entities::Customers
          customer
        end

        desc "Update a customer", {
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
          requires :phone, type: String, desc: "Phone of the customer"
          optional :email, type: String, desc: "Email of the customer"
          optional :gender, type: String, desc: "Gender of the customer"
          optional :name, type: String, desc: "Name of the customer"
          optional :birthday, type: String, desc: "Birthday of the customer"
          optional :union_id, type: String, desc: "Union ID of the customer"
          optional :wechat_data, type: Hash, desc: "Wechat Data of the customer"
          optional :douyin_data, type: Hash, desc: "Douyin Data of the customer"
          optional :agreed_marketing, type: Boolean, desc: "agreed marketing"
        end
        put ":id" do
          current_user!(permitted_params[:id])
          customer_validate = is_platform?('douyin') ? ::DouyinCustomer : ::Customer
          unless customer_validate.by_phone_and_id(permitted_params[:phone], permitted_params[:id]).empty?
            status 400
            return {
                status_code: env['api.endpoint'].status,
                response_type: 'error',
                details: 'This phone is already used by another customer.'
            }
          end
          customer = is_platform?('douyin') ? ::DouyinCustomer.find(permitted_params[:id]) : ::Customer.find(permitted_params[:id])
          if !customer.phone.blank? && customer.phone != permitted_params[:phone]
            status 206
            return { :status_code => env['api.endpoint'].status, :response_type => 'error', :details => 'Unauthorized. You don\'t have access to edit phone.' }
          end
          is_platform?('douyin') ? customer.update(permitted_params.except(:id, :wechat_data)) : customer.update(permitted_params.except(:id, :douyin_data))
          customer.create_crm_number(platform)
          customer.update_member(permitted_params) if permitted_params[:union_id] && !is_platform?('douyin')
          present customer, with: is_platform?('douyin') ? API::Entities::DouyinCustomers : API::Entities::Customers
          customer
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
          requires :customer_id, type: String, desc: "ID of the customer"
        end
        get ":customer_id/member-ship" do
          current_user!(permitted_params[:customer_id])
          customer = is_platform?('douyin') ? ::DouyinCustomer.find(permitted_params[:customer_id]) : ::Customer.find(permitted_params[:customer_id])
          customer.get_membership_info(platform)
        end

        desc "Arvato Livechat Get Access Token API"
        get "arvato/getPublicAccessToken" do
          authentify_livechat!
          token = ::WechatTool::Mp.new().get_token
          return {status: 200, message: "SUCCESS", data: token}
        end

        desc "Arvato Livechat Get User Info API"
        params do
          requires :openId, type: String, desc: "Opend Id Of The Wechat"
        end
        get "arvato/:openId/userInfo" do
          authentify_livechat!
          # validate open id is valid
          customer = ::Customer.where(open_id: permitted_params[:openId]).first
          return {"errcode":40003,"errmsg":"invalid openid"} if !customer
          result = Rails.cache.fetch("arvato_user_info_#{permitted_params[:openId]}", expires_in: 7200) do
            customer.format_wechat_userinfo
          end
          return JSON.parse(result)
        end

      end
    end
  end
end
