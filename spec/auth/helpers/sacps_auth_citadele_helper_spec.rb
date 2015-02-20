# rspec spec/auth/helpers/sacps_auth_citadele_helper_spec.rb

require 'spec_helper'

describe SacPS::Auth::Citadele::Helper do

  let(:helper) { SacPS::Auth::Citadele.helper }

  it "should create correct amount of fields" do
    puts helper.xml
    expect(helper.form_fields.size).to eq 1
  end

  it "should return correct identifier" do
    expect(helper.identifier).to eq 'CitadeleACC1'
  end

  it "should return correct return_url" do
    expect(helper.return_url).to eq "http://www.mycitadele.com"
  end

  it "should make valid xml" do
    array = helper.xml.split("\n")
    expect(array[3]).to include "Timestamp"
  end
end
