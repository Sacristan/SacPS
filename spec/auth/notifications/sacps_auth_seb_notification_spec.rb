# rspec spec/auth/notifications/sacps_auth_seb_notification_spec.rb

require 'spec_helper'

describe SacPS::Auth::Seb::Notification do
  before :all do
    valid_http_raw_data = "IB_SND_ID=ACC1&IB_SERVICE=0001&IB_REC_ID=AAA&IB_USER=050505-12123&IB_DATE=05.12.2003&IB_TIME=10:00:00&IB_USER_INFO=ID=050505-12123;NAME=JOHN DOE&IB_VERSION=001&IB_CRC=LyCZRncu%2F%2BOi5nwzOkI6C9UMFohN6tSl3tLFyIJyNp2lGKBrDKZ2H8b%2BadU3XalzS7MwnAj8r%2FRhLpbsGNE5ysNyM4CKkSrsVzxoXbt9%2BB1foH9Rlp9LCeoR2H774f8UcMe9RVsE%2B%2BZfrEZzzXYyR1PXDCVOShQOAxlD9pbh8nk%3D&IB_LANG=LAT"
    @valid_notification = SacPS::Auth::Seb.notification valid_http_raw_data
  end

  it "should return correct user user_information" do
    expect(@valid_notification.user_information).to eq "050505-12123;JOHN DOE"
  end

  it "should return correct user name" do
    expect(@valid_notification.user_name).to eq "JOHN DOE"
  end

  it "should return correct user identifier" do
    expect(@valid_notification.user_identifier).to eq "050505-12123"
  end

  it "should return correct user language" do
    expect(@valid_notification.user_language).to eq "lv"
  end

end
