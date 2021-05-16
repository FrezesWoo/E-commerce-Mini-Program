module API
  module V1
    class Pages < Grape::API
      include API::V1::Defaults


      resource :pages do

        desc "Show all pages",
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

        get "", serializer: API::Serializers::Pages do
          authenticate!
          ::Page.all
        end

        desc "Show all pages",
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
          requires :slug, type: String, desc: "Search keywords of the page"
        end
        get ":slug" do
          authenticate!
          result = Rails.cache.fetch("page_#{permitted_params[:slug]}", expires_in: 3200) do
            (API::Entities::Pages.new(::Page.find_by_condition(permitted_params[:slug]))).to_json
          end
          JSON.parse(result)
          # page = ::Page.find(permitted_params[:id])
          # present page, with: API::Entities::Pages
          # page
        end

      end
    end
  end
end
