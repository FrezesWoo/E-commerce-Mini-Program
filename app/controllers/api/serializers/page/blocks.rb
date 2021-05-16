module API
    module Serializers
      module Page
        class Blocks < ActiveModel::Serializer
          attributes :id, :created_at, :translations, :template, :status, :link, :ordering, :height, :has_arrows, :has_dots
          has_many :page_block_slides, serializer: Page::Block::Slides
          has_many :page_block_products, serializer: Page::Block::Products
        end
      end
    end
end
