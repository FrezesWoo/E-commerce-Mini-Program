require 'digest'
require 'date'
require 'openssl'
require 'base64'

module Livechat
  class Sign
    def initialize
      @arvato_user = ENV['ARVATO_USER']
      @arvato_password = ENV['ARVATO_PASSWORD']
      @arvato_syscode = ENV['ARVATO_SYSCODE']
    end

    def check_sign(header)
      if header["Arvatouser"] != @arvato_user || header["Arvatopassword"] != @arvato_password || header["Syscode"] != @arvato_syscode || check_proper_time_stamp(header["Timestamp"])
        return false
      end
      md = self.generate_signature(header["Timestamp"])
      return md == header["Sign"]
    end

    def generate_signature(time_stamp)
      md5 = Digest::MD5.new
      md5.update "#{time_stamp}#{@arvato_user}#{@arvato_password}#{@arvato_syscode}"
      md = md5.hexdigest
      md
    end

    private

    def check_proper_time_stamp(time_stamp)
      Time.now.utc.to_i - 3600 < time_stamp.to_i && time_stamp.to_i > Time.now.utc.to_i + 3600
    end

  end
end
