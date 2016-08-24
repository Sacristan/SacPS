module SacPS
  module Auth
    module Banklink
      def generate_signature(service_msg_number, sigparams, required_service_params)
        private_key = self.class.parent.get_private_key
        private_key.sign(OpenSSL::Digest::SHA1.new, generate_data_string(service_msg_number, sigparams, required_service_params))
      end

      def generate_mac(service_msg_number, sigparams, required_service_params)
        Base64.encode64(generate_signature(service_msg_number, sigparams, required_service_params)).gsub(/\n/,'')
      end
    end
  end
end
