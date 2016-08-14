require 'psych'
require 'twitter'
require 'require_all'
require_rel 'app'

client = ClientGenerator.new.get_client

client.update MasterCombinator.new.generate
