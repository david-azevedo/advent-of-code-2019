require 'colorize'

pixels = File.read('../data/day8.txt')

# 150 = 25 * 6

number_of_zeros = 150
number_of_ones = 0
number_of_twos = 0

layers = pixels.scan(/.{150}/)

layers.each do |layer|
  zeros = layer.count('0')
  if zeros < number_of_zeros
    number_of_zeros = zeros
    number_of_ones = layer.count('1')
    number_of_twos = layer.count('2')
  end
end

# PART 1

puts (number_of_ones * number_of_twos)

# PART 2
width = 25
height = 6
image = Array.new(height){Array.new(width,'2')}

layers.each_with_index do |layer, index|
  for h in height.times
    for w in width.times
      if image[h][w] == '2'
        image[h][w] = layer[h * width + w]
      end
    end
  end
end

image.join('').scan(/.{25}/).each do |row|
  for digit in row.split('')
    if digit == '1'
      print 'X'.white
    else
      print 'X'.black
    end
  end
  puts ''
end
