namespace :synchronization do
  desc "synchronize product image file && text field info to product package. terminal command: rake synchronization:sync_package"
  task sync_package: :environment do
    Product.sync_package
  end
end