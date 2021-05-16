class Page < ApplicationRecord
  include SetCurrentUser

  has_one :seo, as: :seoable, dependent: :destroy
  has_many :blocks, -> { order(id: :asc) }, class_name: 'Page::Block', dependent: :destroy

  belongs_to :created_by, class_name: :User
  belongs_to :updated_by, class_name: :User

  accepts_nested_attributes_for :blocks, allow_destroy: true

  attr_accessor :published_blocks

  def self.is_published
    where("pages.status = ?", statuses[:published]).order('page_blocks.ordering asc')
  end

  def published_blocks
    blocks.where("page_blocks.status = ?", Page::Block.statuses[:published]).order('page_blocks.ordering asc')
  end

  def self.find_by_condition(slug)
    if number? slug
      find(slug)
    else
      where('slug ILIKE ?', "%#{slug}%").first!
    end
  end
end
