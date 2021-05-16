class Product < ApplicationRecord
  include SetCurrentUser

  has_many :product_skus, class_name: 'Product::Sku'
  has_many :attachments, -> { order(weight: :asc) }, as: :attachable, dependent: :destroy
  has_many :blocks, class_name: 'Product::Block'

  belongs_to :product_category, class_name: '::Product::Category', foreign_key: 'product_category_id', optional: true
  belongs_to :created_by, class_name: 'User'
  belongs_to :updated_by, class_name: 'User'

  translates :name, :note, :composition, :description

  has_attached_file :image, path: 'public/system/:class/:attachment/:id_partition/:style/:filename',
                            storage: :azure,
                            styles: {
                              thumb: "300x300#"
                            }

  validates_attachment :image, optional: true,
    content_type: { content_type: ["image/png", "image/jpg", "image/jpeg", "image/gif"] },
    size: { in: 0..8.megabytes }

  attr_accessor :image_collection
  accepts_nested_attributes_for :attachments, :blocks, allow_destroy: true

  def image_collection
    product_skus.map(&:attachments).flatten
  end

  def self.sync_package
    puts "#{Time.now}: synchronize product data to product package initialize"
    Product.all.order(:id).each do |product|
      puts "migrate the data of ID:#{product.id} #{product.name} to product package"
      create_or_update_package(product)
    end
    puts "#{Time.now}: synchronize product data to product package end"
  end

  def self.create_or_update_package(product)
    # migrate product data to product_packages table
    package = ::Product::Package.find_or_create_by({name: product.name, product_category_id: product.product_category_id})
    package.update(
        {
            note: product.note,
            description: product.description,
            composition: product.composition,
            star_product: product.star_product,
            ordering: product.ordering,
            created_at: product.created_at,
            updated_at: product.updated_at
        }
    )
    # migrate product azure image to product package
    if !product.image.url.include?('missing') && package.image.url.include?('missing')
      begin
        image = Tempfile.new ['', ".#{product.image.url.split('/').last.gsub(/\?\d{1,}$/, '')}"]
        image.binmode
        image.write open(product.image.url).read
        image.rewind
        package.image = image
        package.save
      rescue => e
        puts e.to_s
      end
    end

    # migrate data to product_package_products table
    package.product_package_products.find_or_create_by(product_id: product.id)

    # migrate data to product_package_product_skus table
    product.product_skus.each do |sku|
      package.product_package_products.each do |products|
        products.skus.find_or_create_by(product_sku_id: sku.id)
      end
    end

    # migrate data to product_package_blocks table
    product.blocks.each do |block|
      package.blocks.find_or_create_by({template: block.template, link: block.link}).update({ordering: block.ordering})
    end

    # migrate product azure attachments to product package
    if product.attachments.count > 0 && package.attachments.count === 0
      product.attachments.each do |attachment|
        begin
          if !attachment.file.url.include?('missing')
            file = Tempfile.new ['', ".#{attachment.file.url.split('/').last.gsub(/\?\d{1,}$/, '')}"]
            file.binmode
            file.write open(attachment.file.url).read
            file.rewind
            package.attachments.create(file: file, weight: attachment.weight, alt: attachment.alt, display: attachment.display, ordering: attachment.ordering)
          end
        rescue => e
          puts "############ We got an error when migrate product attachments #{attachment.to_json}"
          puts e.to_s
        end
      end
    end

  end
end
