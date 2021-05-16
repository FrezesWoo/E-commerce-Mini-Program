module API
  module Entities
    class DouyinCustomers < Grape::Entity
      expose :id
      expose :name
      expose :open_id
      expose :douyin_session_key
      expose :email
      expose :phone
      expose :api_token
      expose :crm_member_no
      expose :gender
      expose :douyin_data
    end
  end
end
