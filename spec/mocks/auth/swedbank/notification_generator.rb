module Mock
  module Auth
    module Swedbank
      class NotificationGenerator
        include SacPS::Auth::Common
        include SacPS::Auth::Banklink

        attr_reader :fields
        # VK_SERVICE
        # VK_VERSION
        # VK_SND_ID
        # VK_REC_ID
        # VK_NONCE
        # VK_INFO
        # VK_ENCODING
        # VK_MAC
        def initialize options={}

          @fields = {}

          @fields['VK_SERVICE']  = '3003'
          @fields['VK_VERSION']  = '008'
          @fields['VK_SND_ID']   = 'HP'
          @fields['VK_REC_ID']   = 'REFEREND'
          @fields['VK_NONCE']    = generate_random_string 50
          @fields['VK_INFO']     = "ISIK:150174-12312;NIMI:KRISTIĀNS BĒRZIŅŠ"
          @fields['VK_ENCODING'] = "UTF-8"
          @fields['VK_MAC'] = generate_mac(@fields['VK_SERVICE'], @fields, SacPS::Auth::Swedbank.required_service_params)
        end

        def generate_raw_response
          values = @fields.collect{|key, value| "#{key}=#{value}"}.join('&')
        end
      end
    end
  end
end
