module API
  module Entities
    class MpImages < Grape::Entity
      expose :id
      expose :name
      expose :image
    end
  end
end
