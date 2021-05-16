require 'digest'
require 'date'
require 'openssl'
require 'base64'

module OmsD
  class OmsSign
    def initialize
      @oms_app_secret = ENV['OMS_APP_SECRET']
      @aes_key = ENV['OMS_AES_KEY']
      @oms_access_key = ENV['OMS_ACCESS_KEY']
      @oms_access_token = ENV['OMS_ACCESS_SECRET']
      # douyin config
      @oms_douyin_app_secret = ENV['OMS_DOUYIN_APP_SECRET']
      @douyin_aes_key = ENV['OMS_DOUYIN_AES_KEY']
    end

    def get_sign(param, source)
      sign = ''
      new_param = Hash[param.sort]
      new_param.each do |k, v|
        new_key = k + '=' + v.to_s + '&'
        sign += new_key
      end
      secret =  source == "wechat" ? 'secret_key=' + @oms_app_secret : 'secret_key=' + @oms_douyin_app_secret
      sign += secret
      puts 'signature is', Digest::MD5.hexdigest(sign).upcase
      Digest::MD5.hexdigest(sign).upcase
    end

    def encrypt_params(params, source)
      cipher = OpenSSL::Cipher::AES.new(128, :ECB)
      cipher.encrypt
      cipher.key = source == "wechat" ? @aes_key : @douyin_aes_key
      encrypted = cipher.update(JSON.dump(params)) + cipher.final
      encrypted = Base64.strict_encode64(encrypted)
      puts 'encrypted params are', encrypted
      encrypted
    end

    def check_sign(header)
      if header["Appsecret"] != @oms_access_token || check_proper_time_stamp(header["Timestamp"])
        return false
      end
      md5 = Digest::MD5.new
      md5.update "#{header["Timestamp"]}#{@oms_access_key}"
      md = md5.hexdigest
      return md == header["Signature"]
    end

    def generate_signature(time_stamp)
      md5 = Digest::MD5.new
      md5.update "#{time_stamp}#{@oms_access_key}"
      md = md5.hexdigest
      md
    end

    private

    def check_proper_time_stamp(time_stamp)
      Time.now.utc.to_i - 3600 < time_stamp.to_i && time_stamp.to_i > Time.now.utc.to_i + 3600
    end

  end
end
