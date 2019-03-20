print "Введите стороны треугольника a,b,c: "
a = gets.to_f
b = gets.to_f
c = gets.to_f

h = a

if b > h
	h = b
end

if c > h
	h = c
end

if (a**2 + b**2 == (h**2).round) && (a == b || b == c || a == c)
	puts "Треугольник прямоугольный и равнобедренный"
elsif (a**2 + b**2 == (h**2).round)
	puts "Треугольник прямоугольный"
elsif a == b && b == c && a == c
	puts "Треугольник равносторонний"
else
	puts "Треугольник равнобедренный"
end