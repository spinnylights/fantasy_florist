require 'twitter'
require_relative './generator.rb'

class ReplyManager
  attr_reader :client
  def initialize(client)
    @client = client
  end

  def last_replied_mention_path
    File.dirname(__FILE__) + '/../last_replied_mention.txt'
  end

  def last_replied_mention_id
    File.open(last_replied_mention_path) {|f| f.read}.to_i
  end

  def gen_reply(sn_to_reply)
    reply_content = ReplyCombinator.new.generate
    reply = "@#{sn_to_reply} #{reply_content}"
    checker = CharChecker.new
    unless checker.check_char_count(reply)
      gen_reply(screen_name)
    end
    reply
  end

  def get_mentions_needing_replies
    client.mentions_timeline(since_id: last_replied_mention_id)
  end

  def reply_as_necessary
    needing_replies = get_mentions_needing_replies
    unless needing_replies.empty?
      needing_replies.each do |tweet|
        sn_to_reply = tweet.user.screen_name
        reply = gen_reply(sn_to_reply)
        client.update(reply, in_reply_to_status: tweet)
      end

      most_recent_replied_to_id = needing_replies.first.id

      File.open(last_replied_mention_path, 'w') do |f|
        f.puts most_recent_replied_to_id
      end
    end
  end
end

