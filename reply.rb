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

last_replied_mention_id = File.open('./last_replied_mention.txt') {|f| f.read}.to_i

def gen_reply(sn_to_reply)
  reply_content = ReplyCombinator.new.generate
  reply = "@#{sn_to_reply} #{reply_content}"
  checker = CharChecker.new
  unless checker.check_char_count(reply)
    gen_reply(screen_name)
  end
  reply
end

mentions_needing_replies = client.mentions_timeline(since_id: last_replied_mention_id)
mentions_needing_replies.each do |tweet|
  sn_to_reply = tweet.user.screen_name
  reply = gen_reply(sn_to_reply)
  client.update(reply, in_reply_to_status: tweet)
end

most_recent_replied_to_id = mentions_needing_replies.first.id

File.open('./last_replied_mention.txt', 'w') do |f| 
  f.puts most_recent_replied_to_id
end
