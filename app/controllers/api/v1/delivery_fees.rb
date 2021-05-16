module API
  module V1
    class DeliveryFees < Grape::API
      include API::V1::Defaults

      resource :'delivery-fees' do

        desc "Get all delivery fees"
        get "", serializer: API::Serializers::DeliveryFees do
          authenticate!
          ::DeliveryFee.all
        end

        desc "Create one delivery fee for a region"
        params do
          requires :province_name, type: String, desc: "Province name"
          optional :free_sample, type: Boolean, desc: "if free sample"
        end
        get ":province_name" do
          authenticate!
          return { price: 20 } if permitted_params[:free_sample]
          ::DeliveryFee.eager_load(country_provinces_delivery_fees: [country_province: :translations]).where('country_province_translations.name = ?', permitted_params[:province_name])
        end

      end
    end
  end
end
