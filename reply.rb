require 'require_all'
require_rel 'app'
require 'chatterbot/dsl'

replies do |tweet|
  reply "#USER# " + ReplyCombinator.new.generate, tweet
end
