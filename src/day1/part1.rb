values = File.readlines('../../data/day1.txt')

fuel_Values = values.map { |value| value.to_i/3.floor - 2 }

total_fuel = fuel_Values.reduce(:+)

#Correct Answer: 3182375
puts total_fuel