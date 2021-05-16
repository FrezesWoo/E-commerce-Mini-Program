module API
  module V2
    class Slides < Grape::API
      include API::V2::Defaults

      resource :slides do

        desc "Return the home slide page"
        get "" do
          slide = ::Campaign.where(publish: true).where(page_type: :slide).first
          present slide, with: API::Entities::Campaigns
          slide
        end

      end
    end
  end
end