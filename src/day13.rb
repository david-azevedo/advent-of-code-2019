def add(code, arr, pos1, pos2, pos3)
  val_1 = convert_mode(code / 100 % 10, arr, pos1)
  val_2 = convert_mode(code / 1000 % 10, arr, pos2)
  val_3 = convert_literal(code / 10_000 % 10, pos3)

  arr[val_3] = val_1 + val_2
end

def multiply(code, arr, pos1, pos2, pos3)
  val_1 = convert_mode(code / 100 % 10, arr, pos1)
  val_2 = convert_mode(code / 1000 % 10, arr, pos2)
  val_3 = convert_literal(code / 10_000 % 10, pos3)

  arr[val_3] = val_1 * val_2
end

def consume_input(code, arr, pos1)
  val_1 = convert_literal(code / 100 % 10, pos1)

  arr[val_1] = $input
end

def write_to_output(code, arr, pos1)
  val_1 = convert_mode(code / 100 % 10, arr, pos1)

  $input = val_1
  $output.push(val_1)
end

def jump_if_true(code, arr, pos1, pos2)
  val_1 = convert_mode(code / 100 % 10, arr, pos1)
  val_2 = convert_mode(code / 1000 % 10, arr, pos2)
  [val_1 != 0, val_2]
end

def jump_if_false(code, arr, pos1, pos2)
  val_1 = convert_mode(code / 100 % 10, arr, pos1)
  val_2 = convert_mode(code / 1000 % 10, arr, pos2)
  [val_1.zero?, val_2]
end

def less_than(code, arr, pos1, pos2, pos3)
  val_1 = convert_mode(code / 100 % 10, arr, pos1)
  val_2 = convert_mode(code / 1000 % 10, arr, pos2)
  val_3 = convert_literal(code / 10_000 % 10, pos3)

  arr[val_3] = val_1 < val_2 ? 1 : 0
end

def equals(code, arr, pos1, pos2, pos3)
  val_1 = convert_mode(code / 100 % 10, arr, pos1)
  val_2 = convert_mode(code / 1000 % 10, arr, pos2)
  val_3 = convert_literal(code / 10_000 % 10, pos3)

  arr[val_3] = val_1 == val_2 ? 1 : 0
end

def add_to_relative_base(code, arr, pos1)
  val_1 = convert_mode(code / 100 % 10, arr, pos1)

  $relative_base += val_1
end

def convert_mode(mode, arr, pos)
  case mode
  when 0
    arr[pos] || 0
  when 1
    pos
  when 2
    arr[$relative_base + pos] || 0
  end
end

def convert_literal(mode, pos)
  case mode
  when 0
    pos
  when 1
    pos
  when 2
    $relative_base + pos
  end
end

def reset_memory
  File.read('../data/day13.txt').split(',').map(&:to_i)
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
      consume_input(code, array, array[index + 1])
      index += 2
    when 4
      # Output
      write_to_output(code, array, array[index + 1])
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
    when 9
      add_to_relative_base(code, array, array[index + 1])
      index += 2
    when 99
      break
    else
      break
    end
  end
end

def reset_globals
  $input = 0
  $relative_base = 0
end

reset_globals
array = reset_memory
$output = []
compute(array)

positions = {}
$output.each_slice(3) do |values|
  positions[[values[0], values[1]]] = values[2]
end

puts positions.values.count(2)
