require 'require_all'
require_rel 'app'
require 'chatterbot/dsl'

tweet MasterCombinator.new.generate

replies do |tweet|
  reply "#USER#" + ReplyCombinator.new.generate
end
