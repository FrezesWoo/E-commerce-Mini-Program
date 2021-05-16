require 'digest'
require 'date'
require 'openssl'
require 'base64'

module CrmShiseido
  class Sign
    def initialize
      @crm_ec_path = ENV["CRM_EC_PATH"]
      @crm_sys_code = ENV["CRM_SYS_CODE"]
      @crm_owner_id = ENV["CRM_OWNER_ID"]
      @crm_sys_key = ENV["CRM_SYS_KEY"]
      @crm_rsa_iv = ENV["CRM_RSA_IV"]
      @crm_base_url = ENV["CRM_BASE_URL"]
      # douyin config
      @crm_douyin_owner_id = ENV["CRM_DOUYIN_OWNER_ID"]
    end

    def generate_signature_base64(owner_id, pos_id, device_id, token, sys_code, post_arg)
      post_arg = post_arg != "" ? post_arg + "&" : ""
      souce_string = post_arg + owner_id + "&" + sys_code + "&" + pos_id + "&" + device_id + "&" + token + "&" + sys_code
      rsa_public = OpenSSL::PKey::RSA.new(File.read(Rails.root.join('private.pem')))
      sign = Base64.strict_encode64(rsa_public.sign("SHA1", souce_string))
      sign
    end

    def md5_hash(sys_key, method, post_arg, sys_code, owner_id, pos_id, device_id, token)
      post_arg = post_arg ? post_arg + "&" : ""
      souce_string = sys_key + "&" + method + "&" + post_arg + sys_code + "&" +
        owner_id + "&" + sys_code + "&" + pos_id + "&" + device_id + "&" + token + "&" + sys_code
      hash_data = Digest::MD5.hexdigest(souce_string)
      hash_data.gsub("-","").upcase!
      hash_data
    end

    def encrypt_to_base64(xml_arg, key_string, iv_string)
      cipher = OpenSSL::Cipher::AES.new(128, :CBC)
      cipher.encrypt
      cipher.key = key_string
      cipher.iv = iv_string
      encrypted = cipher.update(xml_arg) + cipher.final
      result = Base64.strict_encode64(encrypted)
      result
    end

    def decrypt_from_base64(encrypted_base64, key_string, iv_string)
      cipher = OpenSSL::Cipher::AES.new(128, :CBC)
      cipher.decrypt
      cipher.key = key_string
      cipher.iv = iv_string
      encrypted = Base64.strict_decode64(encrypted_base64)
      decrypted = cipher.update(encrypted) + cipher.final
      result = decrypted.force_encoding('UTF-8')
      result
    end

  end
end
