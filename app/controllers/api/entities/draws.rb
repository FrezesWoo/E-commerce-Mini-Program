module API
    module Entities
        class Draws < Grape::Entity
          expose :id
          expose :customer
          expose :name
          expose :lucky_draw_prize, using: API::Entities::Draw::Prizes
          expose :lucky_draw_prize_code, using: API::Entities::Draw::Prize::Codes
          expose :mobile
          expose :encode_mobile
          expose :province
          expose :city
          expose :area
          expose :address
          expose :created_at
          expose :remaining_count
        end
    end
end
