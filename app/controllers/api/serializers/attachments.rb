module API
    module Serializers
        class Attachments < ActiveModel::Serializer
            attributes :id, :attachable_type, :attachable_id, :thumb, :original, :alt, :weight, :display, :ordering
        end
    end
end
