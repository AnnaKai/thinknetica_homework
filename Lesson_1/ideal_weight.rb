print "Ваше имя? "
user_name = gets.chomp

print "Ваш рост в см? "
user_height = gets.chomp.to_i

ideal_weight = user_height - 110

if ideal_weight >= 0
  puts "#{user_name}, ваш идеальный вес - #{ideal_weight}"
else
  puts "Ваш вес уже оптимальный"
end
