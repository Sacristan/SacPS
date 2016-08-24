module SacPS
  module Auth
    module Common
      extend ActiveSupport::Concern
      # p(x) is length of the field x represented by three digits
      def func_p(val)
        sprintf("%03i", val.length)
      end

      # Generate a string to be signed out of service message parameters.
      # p(x1 )|| x1|| p(x2 )|| x2 || ... ||p( xn )||xn
      # || is string concatenation mark
      # p(x) is length of the field x represented by three digits
      # Parameters val1, val2, value3 would be turned into:
      # '003val1003val2006value3'
      def generate_data_string(service_msg_number, sigparams, required_service_params)
        str = ''
        required_params = required_service_params[service_msg_number.to_i] || required_service_params[service_msg_number]

        required_params.each do |param|
          val = sigparams[param].to_s # nil goes to ''
          str << func_p(val) << val
        end
        #binding.pry
        str
      end

      def encode_to_utf8 string
        string.encode('UTF-8', :invalid => :replace, :replace => '').encode('UTF-8')
      end

      # Take the posted data and move the relevant data into a hash
      def parse(post)
        @raw = post.to_s

        for line in @raw.split('&')
          key, value = *line.scan( %r{^([A-Za-z0-9_.]+)\=(.*)$} ).flatten
          params[key] = CGI.unescape(value)
        end
      end

      def generate_random_string length=6
        # ([('a'..'z­'), ('A'.­.'Z'), 0..9]­.map { |i| i.to_­a }.fla­tten).shuf­fle[0,length].j­oin
        char_set = ('0'..'9').to_a

        result = ""
        length.times { result << char_set.sample }
        result
      end

    end
  end
end
