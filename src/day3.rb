def parse_input(input)
  case input[0]
  when 'L'
    x = 1
    y = 0
  when 'R'
    x = -1
    y = 0
  when 'U'
    x = 0
    y = 1
  when 'D'
    x = 0
    y = -1
  end
  [x, y]
end

def apply_move(input, pos_x, pos_y)
  result = []

  x, y = parse_input(input)

  input[1..input.length - 1].to_i.times do
    pos_x += x
    pos_y += y
    result.push([pos_x, pos_y])
  end

  [result, pos_x, pos_y]
end

def wire_to_path(wire)
  cur_x = 0
  cur_y = 0
  positions = []

  wire.each do |input|
    move = apply_move(input, cur_x, cur_y)
    positions.concat(move[0])
    cur_x = move[1]
    cur_y = move[2]
  end

  positions
end

def calc_manhattan(pos)
  pos[0].abs + pos[1].abs
end

def get_steps(pos, wire)
  steps = 0

  wire.each do |p|
    steps += 1
    break if p == pos
  end

  steps
end

wires = File.readlines('../data/day3.txt')

paths = wires.map { |wire| wire_to_path(wire.split(',')) }

intersections = paths.reduce(:&)

steps_sum = intersections.map do |point|
  get_steps(point, paths[0]) + get_steps(point, paths[1])
end

# Correct answer: 37390
puts steps_sum.min
