cart = Hash.new
total_sum = 0

loop do
	puts "Name, price per piece, quantity: "

	name = gets.chomp.downcase
	break if name == "stop"

	price = gets.to_f
	quantity = gets.to_f

	cart[name] = {:price => price, :quantity => quantity}
	puts cart
end

cart.each do |product_name, details|
	temp_sum = details[:price] * details[:quantity]
	puts "#{product_name}: #{temp_sum}"
	total_sum += temp_sum
end

puts total_sum
