module API
  module V1
    class GiftCards < Grape::API
      include API::V1::Defaults

      resource :'gift-cards' do

        desc "Return an gift card", {
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
        get "", serializer: API::Serializers::GiftCards do
          authenticate!
          ::GiftCard.all
        end

      end
    end
  end
end
