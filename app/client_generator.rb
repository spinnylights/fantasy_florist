require 'psych'
require 'twitter'

class ClientGenerator
  def auth_file_path
    File.dirname(__FILE__) + '/../auth.yml'
  end

  def auth
    auth_file = File.open(auth_file_path) {|f| f.read }
    Psych.load auth_file
  end

  def get_client
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = auth[:consumer_key]
      config.consumer_secret     = auth[:consumer_secret]
      config.access_token        = auth[:token]
      config.access_token_secret = auth[:secret]
    end
  end
end
