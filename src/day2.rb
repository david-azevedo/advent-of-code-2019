def add(arr, pos1, pos2, pos3)
  arr[pos3] = arr[pos1] + arr[pos2]
end

def multiply(arr, pos1, pos2, pos3)
  arr[pos3] = arr[pos1] * arr[pos2]
end

def reset_memory
  File.read('../data/day2.txt').split(',').map(&:to_i)
end

# Part 2
desired_output = 19_690_720

# Change this to regular for loop
def compute(array)
  array.each_slice(4) do |code, pos1, pos2, pos3|
    case code
    when 1
      add(array, pos1, pos2, pos3)
    when 2
      multiply(array, pos1, pos2, pos3)
    when 99
      break
    end
  end

  array[0]
end

# Correct answer part 1: 7594646
# Correct answer part 2: 3376

for noun in 0..99 do
  for verb in 0..99 do
    array = reset_memory
    array[1] = noun
    array[2] = verb
    puts 100 * noun + verb if compute(array) == desired_output
  end
end
