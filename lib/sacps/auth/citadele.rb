require 'sacps/auth/citadele/helper'
require 'sacps/auth/citadele/notification'

require 'xmldsig'

module SacPS
  module Auth
    module Citadele
      mattr_accessor :public_key
      mattr_accessor :private_key
      mattr_accessor :service_url

      def self.get_public_key
        cert = self.public_key
        OpenSSL::X509::Certificate.new(cert.gsub(/  /, '')).public_key
      end

      def self.get_private_key
        private_key = self.private_key
        OpenSSL::PKey::RSA.new(private_key.gsub(/  /, ''))
      end

      def self.notification(post)
        Notification.new(post)
      end

      def self.helper(account, options = {})
        Helper.new(account, options)
      end

      def sign_xml xml
        unsigned_document = Xmldsig::SignedDocument.new xml 
        signed_xml = unsigned_document.sign self.class.parent.get_private_key
        is_valid_xml = validate_xml signed_xml
        return signed_xml, is_valid_xml
      end

      def validate_xml signed_xml
        signed_document = Xmldsig::SignedDocument.new signed_xml
        signed_document.validate(self.class.parent.get_public_key)
      end

    end
  end
end  