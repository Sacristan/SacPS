require 'sacps/auth/banklink'
require 'sacps/auth/swedbank/helper'
require 'sacps/auth/swedbank/notification'

module SacPS
  module Auth
    module Swedbank
      mattr_accessor :public_key
      mattr_accessor :private_key
      mattr_accessor :bank_public_key
      mattr_accessor :identifier
      mattr_accessor :service_url
      mattr_accessor :return_url
      mattr_accessor :required_service_params

      def self.get_public_key
        cert = self.public_key
        OpenSSL::X509::Certificate.new(cert.gsub(/  /, '')).public_key
      end

      def self.get_private_key
        private_key = self.private_key
        OpenSSL::PKey::RSA.new(private_key.gsub(/  /, ''))
      end

      def self.get_bank_public_key
        cert = self.bank_public_key
        OpenSSL::X509::Certificate.new(cert.gsub(/  /, '')).public_key
      end

      def self.notification post
        Notification.new post
      end

      def self.helper options={}
        Helper.new options
      end

      self.required_service_params = {
        4002 => [
          'VK_SERVICE',
          'VK_VERSION',
          'VK_SND_ID',
          'VK_REC_ID',
          'VK_NONCE',
          'VK_RETURN'
          ],
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
