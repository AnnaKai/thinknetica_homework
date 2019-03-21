print "Введите стороны треугольника a,b,c: "
side_1 = gets.to_f
side_2 = gets.to_f
side_3 = gets.to_f

sides = [side_1, side_2, side_3].sort

a = sides[0]
b = sides[1]
c = sides[2]

pyth = (a**2).round + (b**2).round == (c**2).round

if (pyth) && (a == b || b == c || a == c)
  puts "Треугольник прямоугольный и равнобедренный"
elsif (pyth)
  puts "Треугольник прямоугольный"
elsif a == b && b == c && a == c
  puts "Треугольник равносторонний"
else
  puts "Треугольник равнобедренный"
end

