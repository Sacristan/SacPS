module Mock
  module Auth
    module Swedbank
      include SacPS::Auth::Common
      include SacPS::Auth::Banklink

      mattr_accessor :public_key
      mattr_accessor :private_key
      mattr_accessor :required_service_params

      def self.get_public_key
        cert = self.public_key
        OpenSSL::X509::Certificate.new(cert.gsub(/  /, '')).public_key
      end

      def self.get_private_key
        private_key = self.private_key
        OpenSSL::PKey::RSA.new(private_key.gsub(/  /, ''))
      end

      self.required_service_params = {
        3003 => [
          'VK_SERVICE',
          'VK_VERSION',
          'VK_SND_ID',
          'VK_REC_ID',
          'VK_NONCE',
          'VK_INFO'
        ]
      }
    end
  end
end
