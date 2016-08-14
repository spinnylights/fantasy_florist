require 'psych'
require 'twitter'
require 'require_all'
require_rel 'app'

client = ClientGenerator.new.get_client
reply_manager = ReplyManager.new(client)
reply_manager.reply_as_necessary
