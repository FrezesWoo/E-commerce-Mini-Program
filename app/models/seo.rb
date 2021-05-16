class Seo < ApplicationRecord
  belongs_to :seoable, polymorphic: true, optional: true
  translates :slug, :meta_keywords, :meta_description, :meta_title
end
