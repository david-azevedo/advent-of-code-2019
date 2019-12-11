require 'matrix'

# (X,Y) (Width, Height)

def count_visible(map, height, width, x_i, y_i)
  directions = []
  height.times.each do |cur_y|
    width.times.each do |cur_x|
      # Most be another asteroid
      next unless map[cur_y][cur_x] == '#'

      # No repeating positions
      next unless cur_y != y_i || cur_x != x_i

      dx, dy = get_vector(cur_x, x_i, cur_y, y_i)
      # puts "(#{dx},#{dy})"
      directions.push([dx, dy])
    end
  end
  directions
end

def get_directions(map, height, width, x_i, y_i)
  directions = []
  height.times.each do |cur_y|
    width.times.each do |cur_x|
      # Most be another asteroid
      next unless map[cur_y][cur_x] == '#'

      # No repeating positions
      next unless cur_y != y_i || cur_x != x_i

      dx = cur_x - x_i
      dy = cur_y - y_i
      # puts "(#{dx},#{dy})"
      directions.push([dx, dy])
    end
  end
  directions
end

def get_vector(cur_x, x_i, cur_y, y_i)
  dx = cur_x - x_i
  dy = cur_y - y_i
  divisor = dx.gcd(dy)
  dx /= divisor
  dy /= divisor
  [dx, dy]
end

def remove_first_different(arr, previous, index)
  
  # TODO debug this function
  return unless arr
  if previous.nil?
    value = Vector[arr[0][0], arr[0][1]].angle_with(Vector[0, -1])
    drop = arr.shift
    $asteroids.push(drop)
    return [arr, value, 0]
  end

  index = 0 if index == arr.length
  while index < arr.length
    d = arr[index]
    v = Vector[d[0], d[1]].angle_with(Vector[0, -1])

    if v != previous
      $asteroids.push(d)
      arr.delete_at(index)
      return [arr, v, index]
    else
      index += 1
    end
  end
end

map = File.readlines('../data/day10.txt').map(&:strip).map(&:chars)
height = map.length
width = map[0].length
most_visible = 0
best_pos = [0, 0]

height.times.each do |y|
  width.times.each do |x|
    # puts "(#{x},#{y})"
    next unless map[y][x] == '#'

    visible = count_visible(map, height, width, x, y).uniq.length

    if visible > most_visible
      best_pos = [x, y]
      most_visible = visible
    end
  end
end

puts "(#{best_pos[0]},#{best_pos[1]}), can see: #{most_visible}"

# PART 2

directions = get_directions(map, height, width, best_pos[0], best_pos[1])

# Sort by angle and then by distance
directions = directions.sort_by do |d| 
  # dist = Math.sqrt(d[0]**2 + d[1]**2)
  dist = d[0].abs + d[1].abs
  # puts "d[0]: #{d[0]}, best_pos[0]: #{best_pos[0]}"
  if d[0] < 0 && 
    ang = Vector[d[0], d[1]].angle_with(Vector[0, -1]) + Math::PI
  else
    ang = Vector[d[0], d[1]].angle_with(Vector[0, -1])
  end
  [ang,dist]
end

#puts directions.join(',')
directions[0..15].map { |d| puts "#{d[0] + best_pos[0]}, #{d[1] + best_pos[1]}"}
$asteroids = []
prev_directions = directions.clone

c = 0
previous_angle = nil
index = 0
while c < prev_directions.length

  c += 1
  directions, previous_angle, index = remove_first_different(directions, previous_angle, index)
end

$asteroids = $asteroids.map { |a| [a[0] + best_pos[0], a[1] + best_pos[1]]}

puts '------------'
puts $asteroids.length
puts $asteroids.uniq.length
$asteroids[0..11].map { |d| puts d.join(',') }
puts $asteroids[199].inspect
#new_directions, previous_angle = remove_first_different(prev_directions, previous_angle)

#destroy_200 = (prev_directions - new_directions)[0]
#destroy_200[0] += best_pos[0]
#destroy_200[1] += best_pos[1]
#puts "(#{destroy_200[0]},#{destroy_200[1]})"

#calc = destroy_200[0] * 100 + destroy_200[1]
#puts "Destroy (#{destroy_200[0]},#{destroy_200[1]}), 100X + Y = #{calc}"
