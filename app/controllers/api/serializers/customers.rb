module API
    module Serializers
        class Customers < ActiveModel::Serializer
            attributes :id, :name, :phone, :email, :api_token, :wechat_data
        end
    end
end
