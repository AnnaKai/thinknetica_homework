# Date#yday and Date#leap not allowed

puts "d:m:yyyy "
day = gets.to_i
month = gets.to_i
year = gets.to_i

months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

if year % 4 != 0 || (year % 100 == 0 && year % 400 != 0)
else
  months[1] = 29
end

value = (months.first(month - 1)).sum + day

puts value
