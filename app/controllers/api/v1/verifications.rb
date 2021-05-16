module API
  module V1
    class Verifications < Grape::API
      include API::V1::Defaults

      resource :verifications do

        desc "Send SMS verifications",
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
          requires :phone, type: String, desc: "Phone of the requester"
        end
        post "/phones" do
          authenticate!
          customer = is_platform?('douyin') ? ::DouyinCustomer : ::Customer
          if !customer.by_phone(permitted_params[:phone]).empty?
            status 204
            return { :status_code => env['api.endpoint'].status, :response_type => 'error', :details => 'This phone number is already in use.' }
          end
          SmsVerificationWorker.perform_async(permitted_params[:phone])
        end

        desc "Check SMS code"
        params do
          requires :phone, type: String, desc: "Phone of the requester"
          requires :code, type: String, desc: "Code of the requester"
        end
        get "/phones/:phone/codes/:code" do
          authenticate!
          sms = SmsVerification.where("phone = ? AND code = ?", permitted_params[:phone], permitted_params[:code])
          expired_at = SmsVerification.arel_table[:expired_at]
          sms = sms.where(expired_at.gt(Time.now)).first
          if sms.nil?
            status 204
            return { :status_code => env['api.endpoint'].status, :response_type => 'error', :details => 'This code does not exists or is expired.' }
          else
            return 'Code is verified'
          end
        end
      end
    end
  end
end
