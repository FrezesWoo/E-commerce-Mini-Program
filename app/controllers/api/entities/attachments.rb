module API
    module Entities
        class Attachments < Grape::Entity
            expose :id
            expose :attachable_type
            expose :attachable_id
            expose :thumb
            expose :original
            expose :alt
            expose :display
            expose :ordering
        end
    end
end
