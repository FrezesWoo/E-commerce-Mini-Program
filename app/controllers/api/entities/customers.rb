module API
    module Entities
        class Customers < Grape::Entity
          expose :id
          expose :name
          expose :open_id
          expose :union_id
          expose :wechat_session_key
          expose :email
          expose :phone
          expose :api_token
          expose :crm_member_no
          expose :gender
          expose :wechat_data
        end
    end
end
