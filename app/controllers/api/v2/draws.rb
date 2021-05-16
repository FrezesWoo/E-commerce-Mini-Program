module API
  module V2
      class Draws < Grape::API
        include API::V2::Defaults
        resource :draws do

          desc "Return lucky draw of customer", {
              headers: {
                  "Authorization" => {
                      description: "Validates your identity",
                      required: true
                  }
              }
          }
          params do
            requires :draw_code, type: Integer, desc: "The code of the draw"
            requires :customer_id, type: String, desc: "Id of the customer"
          end
          get ":draw_code/customers/:customer_id" do
            current_user!(permitted_params[:customer_id])
            lucky_draw = ::LuckyDraw.where.not(lucky_draw_prize_id: nil).where(customer_id: permitted_params[:customer_id]).first
            present lucky_draw, with: API::Entities::Draws
            lucky_draw
          end

          desc "The draws broadcast"
          params do
            requires :draw_code, type: Integer, desc: "The code of the draw"
          end
          get ":draw_code/broadcast", serializer: API::Serializers::Draws do
            lucky_draws = ::LuckyDraw.where.not(lucky_draw_prize_id: nil).order(created_at: :desc).limit(10)
            lucky_draws
          end

          desc "Customer draw", {
              headers: {
                  "Authorization" => {
                      description: "Validates your identity",
                      required: true
                  }
              }
          }
          params do
            requires :draw_code, type: Integer, desc: "The code of the draw"
            requires :customer_id, type: String, desc: "Id of the customer"
          end
          post ":draw_code/customers/:customer_id" do
            current_user!(permitted_params[:customer_id])
            #validate customer lucky draw
            customer = ::Customer.find(permitted_params[:customer_id])
            if !customer.validate_customer_draw
              status 202
              return { status_code: env['api.endpoint'].status, response_type: 'error', details: '您的抽奖次数已用完.'}
            end
            # Dataset
            lucky_draw_prize = LuckyDraw::Prize.get_random_lucky_draw_prize(permitted_params[:customer_id])
            lucky_draw = ::LuckyDraw.create({customer_id: permitted_params[:customer_id], lucky_draw_prize_id: lucky_draw_prize[:lucky_draw_prize_id], lucky_draw_prize_code_id: lucky_draw_prize[:lucky_draw_prize_code_id] })
            present lucky_draw, with: API::Entities::Draws
            lucky_draw
          end

          desc "Customer draw apply", {
              headers: {
                  "Authorization" => {
                      description: "Validates your identity",
                      required: true
                  }
              }
          }
          params do
            requires :draw_code, type: Integer, desc: "The code of the draw"
            requires :id, type: String, desc: "Id of the customer lucky draw"
            requires :customer_id, type: String, desc: "Id of the customer"
            requires :name, type: String, desc: "Name of the customer"
            requires :mobile, type: String, desc: "Phone of the customer"
            requires :province, type: String, desc: "Province of the customer"
            requires :city, type: String, desc: "City of the customer"
            requires :area, type: String, desc: "Area of the customer"
            requires :address, type: String, desc: "Address of the customer"
          end
          post ":draw_code/customers/:customer_id/apply" do
            current_user!(permitted_params[:customer_id])
            # Dataset
            lucky_draw = ::LuckyDraw.find(permitted_params[:id])
            data = { name: permitted_params[:name], mobile: permitted_params[:mobile], province: permitted_params[:province], city: permitted_params[:city], area: permitted_params[:area], address: permitted_params[:address] }
            lucky_draw.update(data)
            present lucky_draw, with: API::Entities::Draws
            lucky_draw
          end

      end
    end
  end
end
