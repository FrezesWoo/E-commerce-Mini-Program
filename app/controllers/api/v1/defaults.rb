module API
  module V1
    module Defaults
      extend ActiveSupport::Concern

      included do
        prefix "api"
        version "v1", using: :path
        default_format :json
        format :json
        # rescue_from :all
        formatter :json,
             Grape::Formatter::ActiveModelSerializers

        helpers do
          def permitted_params
            @permitted_params ||= declared(params,
               include_missing: false)
          end

          def logger
            Rails.logger
          end

          def authenticate!
            auth = !headers['Authorization'].nil? ? headers['Authorization'].gsub("Bearer ", "") : ""
            condition = (headers['Platform'] && headers['Platform'] == 'douyin') ? !::DouyinCustomer.by_auth_token(auth).nil? : !::Customer.by_auth_token(auth).nil?
            error!('Unauthorized. Invalid or expired token.', 401) unless condition
          end

          def current_user!(customer_id)
            auth = !headers['Authorization'].nil? ? headers['Authorization'].gsub("Bearer ", "") : ""
            condition = (headers['Platform'] && headers['Platform'] == 'douyin') ? !::DouyinCustomer.by_auth_token_and_id(auth, customer_id).nil? : !::Customer.by_auth_token_and_id(auth, customer_id).nil?
            error!('Unauthorized. You don\'t have access to these data.', 401) unless condition
          end

          def authentify_oms!
            signed = ::OmsD::OmsSign.new()
            is_signed = signed.check_sign(headers)
            error!('Unauthorized. You don\'t have access to these data.', 401) unless is_signed
          end

          def authentify_livechat!
            signed = ::Livechat::Sign.new()
            is_signed = signed.check_sign(headers)
            error!('Unauthorized. You don\'t have access to these data.', 401) unless is_signed
          end

          def platform
            (headers['Platform'] && !headers['Platform'].nil?) ? headers['Platform'] : 'wechat'
          end

          def is_platform?(source)
            (headers['Platform'] && headers['Platform'] == source) ? true : false
          end

          def oms_source?(source)
            (headers['Apptype'] && headers['Apptype'] == source) ? true : false
          end

        end

        rescue_from ActiveRecord::RecordNotFound do |e|
          error_response(message: e.message, status: 404)
        end

        rescue_from ActiveRecord::RecordInvalid do |e|
          error_response(message: e.message, status: 422)
        end
      end

    end
  end
end
