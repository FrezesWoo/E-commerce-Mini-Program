module API
  module V2
    class Campaigns < Grape::API
      include API::V2::Defaults

      resource :campaigns do

        desc "Return the campaign page", {
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
          campaign = ::Campaign.find(permitted_params[:id])
          present campaign, with: API::Entities::Campaigns
          campaign
        end

      end
    end
  end
end
