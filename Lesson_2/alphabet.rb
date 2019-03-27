result = Hash.new
alphabet = ('a'..'z').to_a
vowels = %w(a e i o u y)

vowels.each do |vowel|
  num = alphabet.find_index(vowel) + 1
  result[vowel] = num
end
