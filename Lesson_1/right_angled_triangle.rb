print "Введите стороны треугольника a,b,c: "
a = gets.to_f
b = gets.to_f
c = gets.to_f

h = a
pyth = b ** 2 + c ** 2 == (h ** 2).round

if b > h
  h = b
  pyth = a ** 2 + c ** 2 == (h ** 2).round
end

if c > h
  h = c
  pyth = a ** 2 + b ** 2 == (h ** 2).round
end

if (pyth) && (a == b || b == c || a == c)
  puts "Треугольник прямоугольный и равнобедренный"
elsif (pyth)
  puts "Треугольник прямоугольный"
elsif a == b && b == c && a == c
  puts "Треугольник равносторонний"
else
  puts "Треугольник равнобедренный"
end
