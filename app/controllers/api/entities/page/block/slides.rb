module API
    module Entities
      module Page
        module Block
          class Slides < Grape::Entity
              expose :id
              expose :ordering
              expose :link
              expose :link_type_id
              expose :page_id
              expose :mp_name
              expose :mp_link
              expose :product_id
              expose :product_sku_id
              expose :product_package_id
              expose :campaign_id
              expose :translations
              expose :original
          end
        end
      end
    end
end
