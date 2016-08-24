module SacPS
  module Auth
    module Swedbank
      class Notification
        include SacPS::Auth::Common
        include SacPS::Auth::Banklink

        attr_accessor :params
        attr_accessor :raw
        attr_accessor :signature

        def initialize(post, options = {})
          @options = options
          emptify!
          parse(post)
        end

        def user_information
          data = params['VK_INFO'].split(";")
          identifier = data.first.split(":").last
          name = data.last.split(":").last
          return "#{identifier};#{name}"
        end

        def user_identifier
          user_information.split(";").first
        end

        def user_name
          user_information.split(";").last
        end

        def user_language
          case params['VK_LANG']
          when "LAT"
            return "lv"
          when "ENG"
            return "en"
          when "RUS"
            return "ru"
          else
            return "lv"
          end
        end

        def valid?
          bank_signature_valid?(params['VK_SERVICE'], params)
        end

        private
          def emptify!
            @params  = Hash.new
            @raw     = ""
          end

          def signature
            Base64.decode64(params['VK_MAC'])
          end

          def bank_signature_valid? service_msg_number, sigparams
            digest = OpenSSL::Digest::SHA1.new
            data_string = generate_data_string(service_msg_number, sigparams, SacPS::Auth::Swedbank.required_service_params)
            SacPS::Auth::Swedbank.get_bank_public_key.verify digest, signature, data_string
          end
      end
    end
  end
end
