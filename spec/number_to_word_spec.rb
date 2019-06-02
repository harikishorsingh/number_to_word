require_relative '../number_to_word'
require 'pry'

describe NumberToWord do
  describe '#letter_combinations' do

    let(:number_to_word) { NumberToWord.new() }

    context 'when invalid number provided' do

      it 'should returns blank array if no numbers is provide' do
        expect(number_to_word.letter_combinations(nil)).to eq []
        expect(number_to_word.letter_combinations('')).to eq []
      end

      it 'should returns blank array if numbers contain 0 or 1' do
        expect(number_to_word.letter_combinations(235012)).to eq []
      end

      it 'should returns blank if numbers length is less tahn 10' do
        expect(number_to_word.letter_combinations(66867878)).to eq []
      end
    end

    context 'when valid numbers is provided' do
      it 'should provide valid result' do
        expected_result1 = [
          ["noun", "struck"],
          ["onto", "struck"],
          ["motor", "truck"],
          ["motor", "usual"],
          ["nouns", "truck"],
          ["nouns", "usual"], 
          "motortruck"
        ]

        expected_result2 =  [
          ["act", "amounts"],
          ["act", "contour"],
          ["bat", "amounts"],
          ["bat", "contour"],
          ["cat", "amounts"],
          ["cat", "contour"],
          ["acta", "mounts"],
          "catamounts"
        ]
        
        expect(number_to_word.letter_combinations(6686787825)).to match_array expected_result1
        expect(number_to_word.letter_combinations(2282668687)).to match_array expected_result2
      end
    end
  end
end