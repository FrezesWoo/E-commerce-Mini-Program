module API
  module Serializers
    class Draws < ActiveModel::Serializer
      attributes :id, :customer, :name, :lucky_draw_prize, :prize_name, :lucky_draw_prize_code, :mobile, :encode_mobile, :province, :city, :area, :address, :created_at
    end
  end
end
