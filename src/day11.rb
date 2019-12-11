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

  # $input = val_1
  if $input_number % 2 == 0 # Paint
    $paint[$pos] = val_1
  else # move
    if val_1.zero?
      $direction = turn_left($direction)
    else # Turn Right
      $direction = turn_right($direction)
    end
    $pos = [$pos[0] + $direction[0], $pos[1] + $direction[1]]
    $input = $paint[$pos] || 0
    $unique_pos.push($pos)
  end

  $input_number += 1
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
  File.read('../data/day11.txt').split(',').map(&:to_i)
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

def turn_left(direction)
  case direction
  when [0, -1]
    [-1,0]
  when [-1, 0]
    [0, 1]
  when [0, 1]
    [1, 0]
  when [1, 0]
    [0, -1]
  end
end

def turn_right(direction)
  case direction
  when [0, -1]
    [1, 0]
  when [-1, 0]
    [0, -1]
  when [0, 1]
    [-1, 0]
  when [1, 0]
    [0, 1]
  end
end

def reset_globals
  $input = 1
  $relative_base = 0
end

$input_number = 0
$paint = {}
$pos = [0, 0]
$direction = [0, -1] # Starts looking up
$unique_pos = [$pos]
reset_globals
array = reset_memory
compute(array)

canvas = x = Array.new(50) { Array.new(50,0) }
$paint.each do |pos, paint|
  canvas[pos[0]][pos[1]] = paint
end

canvas.map { |line| puts line.join(',').gsub('1','#').gsub('0',' ')}
puts $paint.inspect
puts $unique_pos.uniq.length