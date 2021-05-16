class Campaign < ApplicationRecord
  has_many :blocks, -> { order(ordering: :asc) }, class_name: '::Campaign::Block', foreign_key: 'campaign_id'

  enum page_type: { campaign: 1, slide: 2 }
  accepts_nested_attributes_for :blocks, allow_destroy: true
end
