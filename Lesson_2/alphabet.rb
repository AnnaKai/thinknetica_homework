result = Hash.new
alphabet = ('a'..'z')
vowels = %w(a e i o u y)

alphabet.each.with_index(1) do |num, letter|
  result[num] = letter if vowels.include?(num)
end

puts result
