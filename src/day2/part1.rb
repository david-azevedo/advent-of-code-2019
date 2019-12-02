def add(arr, pos1, pos2, pos3)
  arr[pos3] = arr[pos1] + arr[pos2]
end

def multiply(arr, pos1, pos2, pos3)
  arr[pos3] = arr[pos1] * arr[pos2]
end

array = File.read('../../data/day2.txt').split(',').map(&:to_i)

array[1] = 12
array[2] = 2

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

puts array[0]
