pixels = File.read('../data/day8.txt')

width = 25
height = 6
number_of_zeros = width * height
number_of_ones = 0
number_of_twos = 0

layers = pixels.scan(/.{#{Regexp.quote(number_of_zeros.to_s)}}/)

layers.each do |layer|
  zeros = layer.count('0')

  next unless zeros < number_of_zeros

  number_of_zeros = zeros
  number_of_ones = layer.count('1')
  number_of_twos = layer.count('2')
end

# PART 1
puts number_of_ones * number_of_twos

# PART 2
image = Array.new(height) { Array.new(width, '2') }

layers.each do |layer|
  height.times.each do |h|
    width.times.each do |w|
      image[h][w] = layer[h * width + w] if image[h][w] == '2'
    end
  end
end

image.join('').scan(/.{25}/).each do |row|
  row.split('').each do |digit|
    if digit == '1'
      print 'X'
    else
      print ' '
    end
  end
  puts ''
end
