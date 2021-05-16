require 'csv'

module ProductCsv
  class CsvImport

    def upload_product(file)
      CSV.foreach(file.path, headers: :first_row, :encoding => 'UTF-8') do |product_csv|
        product_hash = product_csv.to_h.transform_keys{ |key| key.parameterize().underscore }
        # product = ::Product.where(id: product_hash['product_id']).where(name: product_hash['product_name']).first
        product = ::Product.find(product_hash['product_id'])
        next if product.nil? || product.product_skus.nil?
        # sku list data set
        sku_list_info = Array.new()
        product.product_skus.each do |sku|
          sku_info = Hash.new()
          sku_info['sku_id'] = sku.sku
          sku_info['price'] = sku.price
          sku_info['original_price'] = sku.price
          sku_info['status'] = 1
          sku_list_info.push(sku_info)
        end
        # params data set
        params = {
            product_list:[
                {
                    item_code: product.id,
                    title: product.name,
                    desc: product.note,
                    category_list: [product.product_category.name],
                    image_list: [product.image.url],
                    src_wxapp_path: "/pages/product/index?pid=#{product.id}",
                    sku_list: sku_list_info
                }
            ]
        }

        ProductImportWorker.perform_async(params)
      end
    end

  end
end
