require_relative '../app/lists.rb'
require_relative '../app/a_or_an.rb'

class Generator
  def initialize( string_list )
    @string_list = string_list
  end

  def generate
    @string_list.sample
  end
  
  private

  attr_reader :string_list
end

class FlavorGenerator
  def generate
    'Tastes of ' + FlavorList.sample + '. '
  end
end

class FlowerShapePhraseGenerator
  def generate
    FlowerShapeList.list.sample + '-shaped'
  end
end

class FlowerSizePhraseGenerator
  def generate
    FlowerSizeList.list.sample
  end
end

class FlowerTexturePhraseGenerator
  def generate
    FlowerTextureList.list.sample
  end
end

class FlowerColorPhraseGenerator
  def initialize
    @colors = FlowerColorList.new.list
  end

  def generate
    @colors.sample
  end
end

class FlowerAdjectivesWithoutArePhraseGenerator
  def generate
    FlowerAdjectivesWithoutAreList.list.sample
  end
end

class FlowerPhrasePreCombinator
  def initialize
    @gens_needing_are = flower_phrase_generators_needing_are.shuffle
    @adj_without_are  = FlowerAdjectivesWithoutAreList.list.shuffle
  end

  def generate
    phrases = []
    (1..rand(1..3)).each do |i|
      phrases << generate_phrase
    end
    phrases
  end

  #def generate_without_are
  #  flower_adj_list_without_are.sample
  #end

  #def generate_with_are_not_needed
  #  adj_without_are.sample
  #end

  private

  def generate_phrase
    chance = rand(1..3)
    if chance == 1
      @adj_without_are.pop
    else
      adj_with_are_provided
    end
  end

  def flower_phrase_generators_needing_are
    [
      FlowerShapePhraseGenerator,
      FlowerSizePhraseGenerator,
      FlowerTexturePhraseGenerator,
      FlowerColorPhraseGenerator
    ]
  end

  def a_flower_phrase_generator_needing_are
    @gens_needing_are.pop.new
  end

  def flower_adj_list_without_are
    FlowerAdjectivesList.list + FlowerAdjectivesWithoutAreList.list
  end

  def flower_adj_list
    adj_given_are + adj_without_are
  end

  #def adj_given_are
  #  a_flower_phrase_generator_needing_are.list.map do |adj|
  #    "are #{adj}"
  #  end
  #end

  def adj_with_are_provided
    'are ' + a_flower_phrase_generator_needing_are.generate
  end

  def adj_without_are
    FlowerAdjectivesWithoutAreList.list
  end
end

class SimpleCombinator
  def initialize( gen_one, gen_two )
    @gen_one = gen_one
    @gen_two = gen_two
  end

  def generate
    gen_one.generate + ' ' + gen_two.generate
  end

  private
  
  attr_reader :gen_one,
              :gen_two
end

class FlowerPhraseCombinator
  def generate
    phrases = FlowerPhrasePreCombinator.new.generate
    if phrases.length == 1
      one_phrase( phrases[0] )
    elsif phrases.length == 2
      two_phrases( phrases[0], phrases[1] )
    else
      three_phrases( phrases[0], phrases[1], phrases[2] )
    end
  end

  private

  def one_phrase( phrase )
    prefix + phrase + '.'
  end

  def two_phrases( step_one, step_two )
    step_one = prefix + step_one
    if step_one.include? 'are'
      step_two = remove_are( step_two )
      two_phrase_scaffold( step_one, step_two )
    else
      two_phrase_scaffold( step_one, step_two )
    end
  end

  def three_phrases( step_one, step_two, step_three )
    step_one = prefix + step_one
    if step_one.include?( 'are' )
      if step_two.include?( 'are' )
        step_two = remove_are(step_two)
        step_three = remove_are( step_three )
        three_phrase_scaffold(step_one, step_two, step_three)
      else
        #this branch produces an awkward sentence
        #three_phrases( step_one, step_two, step_three )
        generate
      end
    else
      if step_two.include?( 'are' )
        if step_three.include?( 'are' )
          step_three = remove_are(step_three)
          three_phrase_scaffold_no_commas(step_one, step_two, step_three)
        else
          three_phrase_scaffold(step_one, step_two, step_three)
        end
      else
        three_phrase_scaffold(step_one, step_two, step_three)
      end
    end
  end

  #def step_one
  #  step_one = prefix + phrase_chunk_with_necessary_are
  #end

  def two_phrase_scaffold( part_one, part_two )
    part_one + ' and ' + part_two + '.'
  end

  def three_phrase_scaffold( part_one, part_two, part_three )
    part_one + ', ' + part_two + ', and ' + part_three + '.' 
  end

  def three_phrase_scaffold_no_commas( part_one, part_two, part_three )
    part_one + ' and ' + part_two + ' and ' + part_three + '.'
  end

  def prefix
    "Flowers "
  end

  def phrase_chunk_with_necessary_are
    FlowerPhrasePreCombinator.new.generate
  end

  def phrase_chunk_without_are
    FlowerPhrasePreCombinator.new.generate_without_are
  end

  def remove_are( str )
    str.split('are ').pop
  end
end

class MasterCombinator
  def generate
    str = pre_generate
    if check_char_count( str )
      str
    else
      generate
    end
  end

  private

  def pre_generate
    str = []
    #life_cycle_type +
    str << probably( flavor )
    str << probably( fruit_type )
    str << probably( edibility )
    str.shuffle!
    str.unshift( flower_desc )
    str.unshift( flower_name )
    str.join
  end

  def check_char_count( str )
    if str.length > char_count
      false
    else
      true
    end
  end

  def char_count
    140
  end

  def pick_one( one, two )
    chance = rand(1..2)
    if chance == 1
      one
    else
      two
    end
  end

  def maybe( string_gen )
    chance = rand(1..3)
    if chance > 2
      string_gen
    else
      ''
    end
  end

  def small_chance( string_gen )
    chance = rand(1..4)
    if chance == 1
      string_gen
    else
      ''
    end
  end

  def probably( string_gen )
    chance = rand(1..5)
    if chance == 1
      ''
    else
      string_gen      
    end
  end

  def flower_name
    "#{flower_name_comb.generate}: "
  end

  def life_cycle_type
    "#{life_cycle_type_gen.generate}. "
  end

  def fruit_type
    fruit_type = fruit_type_gen.generate
    "Fruit #{a_or_an( fruit_type )} #{fruit_type}. "
  end

  def flower_desc
    FlowerPhraseCombinator.new.generate + ' '
  end
  
  def flavor
    FlavorGenerator.new.generate
  end

  def edibility
    "#{edibility_gen.generate} "
  end

  def a_or_an( word )
    AOrAn.a_or_an( word )
  end

  def floral_prefix_gen
    Generator.new( FloralPrefixList.list )
  end

  def flower_name_gen
    Generator.new( FlowerNameList.list )
  end

  def life_cycle_type_gen
    Generator.new( LifeCycleTypeList.list )
  end

  def fruit_type_gen
    Generator.new( FruitTypeList.list )
  end

  def edibility_gen
    Generator.new( EdibilityList.list )
  end

  def flower_name_comb
    SimpleCombinator.new(
      floral_prefix_gen,
      flower_name_gen
    )
  end
end
