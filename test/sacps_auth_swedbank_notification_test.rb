# encoding: utf-8

require File.dirname(__FILE__) + '/test_helper'

class SacPSAuthSwedbankNotificationtest < Minitest::Test
  # include Banklink

  def setup
    @swedbank_auth = SacPS::Auth::Swedbank.notification(http_raw_data)
  end

  def test_accessors
    assert_equal "PERSON:37508166516;NAME:JOHN DOE", @swedbank_auth.user_information
  end

  private
    def http_raw_data
      "VK_SERVICE=3003&VK_VERSION=008&VK_SND_ID=TEST&VK_REC_ID=TEST&VK_NONCE=25254142330344004260105519515191011979668867223483&VK_INFO=PERSON:37508166516;NAME:JOHN DOE&VK_MAC=LyCZRncu%2F%2BOi5nwzOkI6C9UMFohN6tSl3tLFyIJyNp2lGKBrDKZ2H8b%2BadU3XalzS7MwnAj8r%2FRhLpbsGNE5ysNyM4CKkSrsVzxoXbt9%2BB1foH9Rlp9LCeoR2H774f8UcMe9RVsE%2B%2BZfrEZzzXYyR1PXDCVOShQOAxlD9pbh8nk%3D&VK_LANG=LAT&VL_ENCODING=UTF-8"
    end

end
