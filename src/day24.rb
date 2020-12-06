lines = File.readlines("../data/#{__FILE__.split('.')[0]}.txt").map(&:strip)

def cal_bio(layout)
  bin_layout = layout.join.reverse.gsub('#', '1').gsub('.', '0')
  bin_layout.to_i(2)
end

starting_layout = lines
previous_layouts = { starting_layout.join => 1 }
stop = false

until stop
  next_layout = Array.new(5) { '.....' }

  25.times do |i|
    r = i / 5
    c = i % 5
    adjacent = [[r - 1, c], [r + 1, c], [r, c + 1], [r, c - 1]]

    n_bugs = 0
    adjacent.each do |adj|
      if adj[0] < 5 && adj[0] >= 0 && adj[1] < 5 && adj[1] >= 0
        n_bugs += 1 if starting_layout[adj[0]][adj[1]] == '#'
      end
    end

    next_layout[r][c] = starting_layout[r][c]

    if starting_layout[r][c] == '#'
      next_layout[r][c] = '.' unless n_bugs == 1
    end

    if starting_layout[r][c] == '.'
      next_layout[r][c] = '#' if [1, 2].include?(n_bugs)
    end
  end

  starting_layout = next_layout
  if previous_layouts[starting_layout.join] == 1
    stop = true
    next
  end

  previous_layouts[starting_layout.join] = 1
end

puts cal_bio(starting_layout)
