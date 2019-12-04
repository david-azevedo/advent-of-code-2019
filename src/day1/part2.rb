def calc_fuel(size)
    size/3.floor - 2
end

def recursive_fuel(fuel)
    needed_fuel = calc_fuel(fuel)
    return 0 unless needed_fuel > 0
    recursive_fuel(needed_fuel) + needed_fuel
end

values = File.readlines('../../data/marco.txt')

fuel_values = values.map { |value| calc_fuel(value.to_i) + recursive_fuel(calc_fuel(value.to_i)) }

total_fuel = fuel_values.reduce(:+)

#Correct Answer: 4770725
puts total_fuel