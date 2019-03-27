arr = []
i = 0; a = 0; b = 1

while a <= 100 do
		arr[i] = a
		i += 1
		a, b = b, a + b
end
