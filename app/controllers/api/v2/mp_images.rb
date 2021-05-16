module API
  module V2
    class MpImages < Grape::API
      include API::V2::Defaults

      resource :mp_images do

        desc "Show one specific Mp Image"
        params do
          requires :slug, type: String, desc: "slug of the mp image"
        end
        get ":slug" do
          mp_image = MpImage.where('name ILIKE ?', "%#{permitted_params[:slug]}%").first!
          present mp_image, with: API::Entities::MpImages
          mp_image
        end

      end
    end
  end
end
