module API
    module Serializers
        class Pages < ActiveModel::Serializer
          attributes :id, :created_at, :published_blocks
          # has_many :published_blocks, serializer: Page::Blocks
        end
    end
end
