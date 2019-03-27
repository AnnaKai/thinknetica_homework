months = [:jan, :feb, :mar, :apr, :may, :june, :july, :aug, :sept, :oct, :nov, :dec]
days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
days_in_month = Hash[months.zip(days)]

days_in_month.each { |key, value| if value == 30 then puts key end }
