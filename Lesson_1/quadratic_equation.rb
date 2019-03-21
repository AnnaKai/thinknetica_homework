print "Введите 3 коэффициента a,b,c: "
a = gets.to_f
b = gets.to_f
c = gets.to_f

d = b**2 - 4 * a * c

if d < 0
  puts "Дискриминант меньше 0. Решений нет"
else
  sqrt_d = Math.sqrt(d)
  x_1 = (-b + sqrt_d) / (2 * a)
  x_2 = (-b - sqrt_d) / (2 * a)
  if x_1 == x_2
    puts "Корень x1 = x2 = #{x_1}"
  else
    puts "Корни x1 = #{x_1} и x2 = #{x_2}"
  end
end

