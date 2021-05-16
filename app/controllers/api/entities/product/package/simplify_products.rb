module API
  module Entities
    module Product
      module Package
        class SimplifyProducts < Grape::Entity
          expose :id
          expose :image
          expose :translations
          expose :attachments, using: API::Entities::Attachments
        end
      end
    end
  end
end
