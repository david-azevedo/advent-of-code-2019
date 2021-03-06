def get_elem_amount(input)
  input.split(' ').map(&:strip)
end

def get_input_and_output(reaction)
  reaction.split('=>').map(&:strip)
end

def get_elems(input)
  input.split(',').map(&:strip)
end

def get_reaction(reactions, elem)
  reactions.each do |reaction|
    return reaction if reaction.end_with? elem
  end
end

def update_amounts(elems, multiplier)
  result = []
  elems.each do |elem|
    amount, el = get_elem_amount(elem)
    result.push("#{amount.to_i * multiplier} #{el}")
  end
  result
end

def fuel_to_ore(reactions, needed_materials)
  ore_amount = 0
  leftovers = {}
  while !needed_materials.empty?

    amount_needed, material = get_elem_amount(needed_materials.shift)
    amount_needed = amount_needed.to_i
    amount_needed -= leftovers[material].to_i

    if amount_needed.zero?
      leftovers[material] = 0
      next
    end

    if amount_needed.negative?
      leftovers[material] = amount_needed.abs
      next
    end

    reaction = get_reaction(reactions, material)

    # Get reaction input and output
    input, output = get_input_and_output(reaction)

    input_elems = get_elems(input)

    amount_can_be_produced, = get_elem_amount(output)
    amount_can_be_produced = amount_can_be_produced.to_i

    # If we need more than what 1 reaction produces
    if amount_can_be_produced < amount_needed
      multiplier = (amount_needed / amount_can_be_produced.to_f).ceil
      leftover_amount = multiplier * amount_can_be_produced - amount_needed
      leftovers[material] = leftover_amount
      input_elems = update_amounts(input_elems, multiplier)
    end

    # Leftover amounts
    if amount_can_be_produced >= amount_needed
      leftover_amount = amount_can_be_produced - amount_needed
      leftovers[material] = leftover_amount
    end

    #Remove ORES
    new_input_elems = []
    input_elems.each do |elem|
      amount, element = get_elem_amount(elem)
      if element == 'ORE'
        ore_amount += amount.to_i
      else
        new_input_elems.push(elem)
      end
    end

    #Add new needed elems
    needed_materials.concat(new_input_elems)
  end
  ore_amount
end

reactions = File.readlines('../data/day14.txt').map(&:strip)

# PART 1
ore_amount = fuel_to_ore(reactions, ['1 FUEL'])
puts ore_amount

# PART 2
low_fuel = 1
high_fuel = 1_941_480
fuel_amount = 0
ore_capacity = 1_000_000_000_000

while true
  mid_fuel = (high_fuel + low_fuel) / 2

  mid_ores = fuel_to_ore(reactions, ["#{mid_fuel} FUEL"])

  if high_fuel - low_fuel == 1
    fuel_amount = low_fuel
    break
  end
  
  if mid_ores > ore_capacity
    high_fuel = mid_fuel
    next
  end

  if mid_ores < ore_capacity
    low_fuel = mid_fuel
    next
  end

end

puts fuel_amount
