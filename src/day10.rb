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

def destroy_asteroids(arr)

  destroyed = []
  previous = nil
  index = 0

  while arr.length != 0
    if index == arr.length
      index = 0
      previous = nil
    end

    if previous.nil?
      previous = Vector[arr[0][0], arr[0][1]].angle_with(Vector[0, -1])
      drop = arr.shift
      destroyed.push(drop)
      next
    end

    d = arr[index]
    v = Vector[d[0], d[1]].angle_with(Vector[0, -1])

    if v != previous
      previous = v
      destroyed.push(d)
      arr.delete_at(index)
      next
    else
      index += 1
    end
  end
  destroyed
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
  dist = d[0].abs + d[1].abs
  
  if (d[0]).negative?
    ang = (2 * Math::PI) - Vector[d[0], d[1]].angle_with(Vector[0, -1])
  else
    ang = Vector[d[0], d[1]].angle_with(Vector[0, -1])
  end
  [ang, dist]
end

# puts directions.map { |d| [d[0] + best_pos[0], d[1] + best_pos[1]] }.inspect

asteroids = destroy_asteroids(directions)

asteroids = asteroids.map { |a| [a[0] + best_pos[0], a[1] + best_pos[1]]}

puts asteroids[0].inspect
puts asteroids[1].inspect
puts asteroids[2].inspect
puts asteroids[9].inspect
puts asteroids[19].inspect
puts asteroids[49].inspect
puts asteroids[99].inspect
puts asteroids[199].inspect
puts asteroids[200].inspect
puts asteroids[298].inspect
