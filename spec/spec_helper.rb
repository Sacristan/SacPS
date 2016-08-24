require 'bundler/setup'
Bundler.setup

$LOAD_PATH << File.expand_path("spec/mocks")
require 'sacps'
require 'mock'
require 'priscilla'
require 'timecop'
require 'pry'

RSpec.configure do |config|
  require 'dotenv'
  Dotenv.load
  require "config"
end

class TEST
  AUTH_RESPONSE_WITHOUT_PK = {
    "apikey"=>"893622a604f3afe374307e88c8a085c1", "uid"=>"5336961", "language"=>"lv", "users"=> {
      "5336961"=> {
        "uid"=>5336961,
        "name"=>"Augusts",
        "url"=>"/user/5336961/",
        "surname"=>"Bautra",
        "nick"=>"",
        "emailHash"=>"2ca63b0c1c9d2c91e200ac5b26b28bd1",
        "place"=>"1",
        "sex"=>"M",
        "birthday"=>"1988-11-26",
        "age"=>26,
        "adult"=>1,
        "type"=>"User_Default",
        "deleted"=>false,
        "created"=>"24.09.2015 12:28:27",
        "pk"=>""
      }
    }
  }
  AUTH_RESPONSE_WITH_PK = {
    "apikey"=>"893622a604f3afe374307e88c8a085c1", "uid"=>"5336961", "language"=>"lv", "users"=> {
      "5336961"=> {
        "uid"=>5336961,
        "name"=>"Jānis",
        "url"=>"/user/5336961/",
        "surname"=>"Bērziņš",
        "nick"=>"",
        "emailHash"=>"2ca63b0c1c9d2c91e200ac5b26b28bd1",
        "place"=>"1",
        "sex"=>"M",
        "birthday"=>"1988-11-26",
        "age"=>26,
        "adult"=>1,
        "type"=>"User_Default",
        "deleted"=>false,
        "created"=>"24.09.2015 12:28:27",
        "pk"=>"123456-12345"
      }
    }
  }

end
