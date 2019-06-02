require 'pry'
require 'date'

class NumberToWord
  def letter_combinations(numbers)
    time_start = Time.now()
    digits = numbers.to_s
    #return if number is not valid
    return [] if digits === '' || digits.length != 10 || digits.split('').select{|digit|(digit.to_i == 0 || digit.to_i == 1)}.length > 0
    # get all letters for digits in form of array
    keys = digits.chars.map{ |number| letters_mapping[number] }
    dictionary = dictionary_words
    results = get_matched_word(keys, dictionary)
    final_words = get_arranged_words(results)
    # for all digits
    final_words << (keys.shift.product(*keys).map(&:join) & dictionary[11]).join(", ") # match with all character
    puts "Time #{Time.now().to_f - time_start.to_f}"
    final_words
  end

  private

  def letters_mapping
    {
      "2" => ["a", "b", "c"],
      "3" => ["d", "e", "f"],
      "4" => ["g", "h", "i"],
      "5" => ["j", "k", "l"],
      "6" => ["m", "n", "o"],
      "7" => ["p", "q", "r", "s"],
      "8" => ["t", "u", "v"],
      "9" => ["w", "x", "y", "z"]
    }
  end

  # Read dictionary file and hold all values in a hash
  def dictionary_words
    dictionary = {}
    for i in (1..30)
      dictionary[i] = []
    end

    file_path = "dictionary.txt"
    File.foreach( file_path ) do |word|
      dictionary[word.length] << word.chop.to_s.downcase
    end
    dictionary
  end

  def get_matched_word(keys, dictionary)
    results = {}
    total_number = keys.length - 1
    #Loop through all letters and get matching records with dictionary
    for i in (2..total_number)
      first_array = keys[0..i]
      next if first_array.length < 3 
      second_array = keys[i + 1..total_number]
      next if second_array.length < 3
    
      first_combination = first_array.shift.product(*first_array).map(&:join) # Get product of arrays
      next if first_combination.nil?
      second_combination = second_array.shift.product(*second_array).map(&:join)
      next if second_combination.nil?
      results[i] = [(first_combination & dictionary[i+2]), (second_combination & dictionary[total_number - i +1])] # get common values from arrays
    end
    results
  end

  def get_arranged_words(results)
    #arrange words
    final_words = []
    results.each do |key, combinataions|
      next if combinataions.first.nil? || combinataions.last.nil?
      combinataions.first.product(combinataions.last).each do |combo_words|
        final_words << combo_words
      end
    end
    final_words 
  end

end


# final_words = NumberToWord.new().letter_combinations(6686787825)
# print final_words

