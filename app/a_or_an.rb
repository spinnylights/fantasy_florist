module AOrAn
  def self.a_or_an( word )
    if vowels.include? get_first_letter( word )
      'an'
    else
      'a'
    end
  end
  
  private

  def self.get_first_letter( word )
    word.slice(0)
  end

  def self.vowels
    [
      'a',
      'e',
      'i',
      'o',
      'u'
    ]
  end
end
