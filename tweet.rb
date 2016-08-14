require 'psych'
require 'twitter'
require 'require_all'
require_rel 'app'

auth_file = File.open('./auth.yml') {|f| f.read }
auth = Psych.load auth_file

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = auth[:consumer_key]
  config.consumer_secret     = auth[:consumer_secret]
  config.access_token        = auth[:token]
  config.access_token_secret = auth[:secret]
end

client.update MasterCombinator.new.generate
