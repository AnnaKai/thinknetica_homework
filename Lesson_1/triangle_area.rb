print "Основание треугольника: "
a = gets.chomp.to_f

print "Высота треугольника: "
h = gets.chomp.to_f

area = (a*h)/2
area = area == area.to_i ? area.to_i : area

puts "Площадь треугольника: #{area}"