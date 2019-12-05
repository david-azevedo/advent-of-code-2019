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
  arr[pos1] = $input
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
  File.read('../../data/day5.txt').split(',').map(&:to_i)
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

  array[0]
end

$input = 5

array = reset_memory()

compute(array)

puts $input