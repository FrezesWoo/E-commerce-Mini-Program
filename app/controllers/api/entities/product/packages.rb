module API
  module Entities
    module Product
      class Packages < Grape::Entity
          expose :id
          expose :note
          expose :description
          expose :translations
          expose :product_category
          expose :image
          expose :hidden_product
          expose :publish
          expose :shipping_price
          expose :page_id
          expose :attachments, using: API::Entities::Attachments
          expose :product_package_products, using: API::Entities::Product::Package::Products
          expose :blocks, using: API::Entities::Product::Package::Blocks
      end
    end
  end
end
