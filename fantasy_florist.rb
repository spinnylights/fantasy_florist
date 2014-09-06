require 'require_all'
require_all 'app'

#floral_prefix_gen = Generator.new( FloralPrefixList.list )
#flower_name_gen = Generator.new( FlowerNameList.list )
#flower_name_comb = SimpleCombinator.new(
#  floral_prefix_gen,
#  flower_name_gen
#)

#puts FlowerPhraseCombinator.new.generate

puts MasterCombinator.new.generate
