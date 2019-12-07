def add(code, arr, pos1, pos2, pos3)
  val_1 = (code / 100 % 10).zero? ? arr[pos1] : pos1
  val_2 = (code / 1000 % 10).zero? ? arr[pos2] : pos2
  arr[pos3] = val_1 + val_2
end

def multiply(code, arr, pos1, pos2, pos3)
  val_1 = (code / 100 % 10).zero? ? arr[pos1] : pos1
  val_2 = (code / 1000 % 10).zero? ? arr[pos2] : pos2
  arr[pos3] = val_1 * val_2
end

def consume_input(arr, pos1)
  if $is_first_input
    arr[pos1] = $phase
    $is_first_input = false
  else
    arr[pos1] = $input
  end
end

def write_input(arr, pos1)
  $input = arr[pos1]
end

def jump_if_true(code, arr, pos1, pos2)
  val_1 = (code / 100 % 10).zero? ? arr[pos1] : pos1
  val_2 = (code / 1000 % 10).zero? ? arr[pos2] : pos2
  [val_1 != 0, val_2]
end

def jump_if_false(code, arr, pos1, pos2)
  val_1 = (code / 100 % 10).zero? ? arr[pos1] : pos1
  val_2 = (code / 1000 % 10).zero? ? arr[pos2] : pos2
  [val_1.zero?, val_2]
end

def less_than(code, arr, pos1, pos2, pos3)
  val_1 = (code / 100 % 10).zero? ? arr[pos1] : pos1
  val_2 = (code / 1000 % 10).zero? ? arr[pos2] : pos2

  arr[pos3] = val_1 < val_2 ? 1 : 0
end

def equals(code, arr, pos1, pos2, pos3)
  val_1 = (code / 100 % 10).zero? ? arr[pos1] : pos1
  val_2 = (code / 1000 % 10).zero? ? arr[pos2] : pos2

  arr[pos3] = val_1 == val_2 ? 1 : 0
end

def reset_memory
  File.read('../data/day7.txt').split(',').map(&:to_i)
end

# Change this to regular for loop
def compute(array)
  index = 0
  while index < array.length
    code = array[index]
    instruction = code % 100
    case instruction
    when 1
      add(code, array, array[index + 1], array[index + 2], array[index + 3])
      index += 4
    when 2
      multiply(code, array, array[index + 1], array[index + 2], array[index + 3])
      index += 4
    when 3
      # Input
      consume_input(array, array[index + 1])
      index += 2
    when 4
      # Output
      write_input(array, array[index + 1])
      index += 2
    when 5
      bool, new_index = jump_if_true(code, array, array[index + 1], array[index + 2])

      index = bool ? new_index : index + 3
    when 6
      bool, new_index = jump_if_false(code, array, array[index + 1], array[index + 2])

      index = bool ? new_index : index + 3
    when 7
      less_than(code, array, array[index + 1], array[index + 2], array[index + 3])
      index += 4
    when 8
      equals(code, array, array[index + 1], array[index + 2], array[index + 3])
      index += 4
    when 99
      break
    end
  end 

  # array[0]
end

permutations = [5, 6, 7, 8, 9].permutation.to_a
$input = 0
$phase = 0
$is_first_input = true
max_output = 0

permutations.each do |permutation|
  $input = 0
  permutation.each do |phase_setting|
    $phase = phase_setting
    $is_first_input = true
    array = reset_memory
    compute(array)
  end

  max_output = $input unless $input < max_output
end

puts max_output