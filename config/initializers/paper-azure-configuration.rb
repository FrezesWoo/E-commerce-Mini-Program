# [rails_root]/config/initializers/paperclip-azure-configuration.rb
Paperclip::Attachment.default_options[:storage] = :azure
Paperclip::Attachment.default_options[:azure_credentials] = {
    storage_account_name: ENV['AZURE_STORAGE_ACCOUNT'],
    storage_access_key:   ENV['AZURE_STORAGE_ACCESS_KEY'],
    container:            ENV['AZURE_CONTAINER_NAME'],
    region:               :cn
}
