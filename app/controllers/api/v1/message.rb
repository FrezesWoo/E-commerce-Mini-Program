# encoding: utf-8

module API
  module V1
    class Message < Grape::API
      content_type :xml, 'text/xml'
      content_type :txt, 'text/plain'
      default_format :xml
      format :txt
      prefix "api"
      version "v1", using: :path
      formatter :xml, lambda { |object, env| object.to_xml(root: 'xml', dasherize: false, skip_instruct: true, skip_types: true) }

      resource :wechat do
        desc "validate message signature"
        params do
          requires :signature, type: String, desc: "signature from the wechat server"
          requires :timestamp, type: String, desc: "timestamp from the wechat server"
          requires :nonce, type: String, desc: "nonce from the wechat server"
          requires :echostr, type: String, desc: "echostr from the wechat server"
        end
        get "message", root: :wechat do
          status 200
          wechat = ::WechatTool::Mp.new()
          return {return_code: "FAIL", return_msg: "签名失败"} if !wechat.check_message_signature(params[:signature], params[:timestamp], params[:nonce])
          return params[:echostr]
        end

        desc "push mp message"
        post "message", root: :wechat do
          status 200
          wechat = ::WechatTool::Mp.new()
          if wechat.check_message_signature(params[:signature], params[:timestamp], params[:nonce])
            message = params["xml"]
            ::Livechat::SendMessage.new().push(message) if message['MsgType'] == 'text' || message['MsgType'] == 'image'
            return "SUCCESS"
          end
        end
      end
    end
  end
end
