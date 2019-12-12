class Moon
  attr_reader :x
  attr_reader :y
  attr_reader :z
  
  def initialize(x, y, z)
    @x = x
    @y = y
    @z = z
    @vx = 0
    @vy = 0
    @vz = 0
  end

  def move
    @x += @vx
    @y += @vy
    @z += @vz
  end

  def update_speed(moon_array, my_index)
    moon_array.each_with_index do |moon, index|
      next if index == my_index

      @vx += compare_coord(@x,moon.x)
      @vy += compare_coord(@y,moon.y)
      @vz += compare_coord(@z,moon.z)
    end
  end

  def pot_energy
    @x.abs + @y.abs + @z.abs
  end

  def kin_energy
    @vx.abs + @vy.abs + @vz.abs
  end

  def total_energy
    pot_energy * kin_energy
  end
end

def compare_coord(coord_1, coord_2)
  return 0 if coord_1 == coord_2
  return 1 if coord_1 < coord_2
  -1
end

moon_array = []
moon_array.push(Moon.new(-7,-1,6))
moon_array.push(Moon.new(6,-9,-9))
moon_array.push(Moon.new(-12,2,-7))
moon_array.push(Moon.new(4,-17,-12))

#moon_array.push(Moon.new(-1,0,2))
#moon_array.push(Moon.new(2,-10,-7))
#moon_array.push(Moon.new(4,-8,8))
#moon_array.push(Moon.new(3,5,-1))


timesteps = 1000

timesteps.times.each do
  # Update speeds
  moon_array.each_with_index do |moon, index|
    moon.update_speed(moon_array,index)
  end

  # Move
  moon_array.each do |moon|
    moon.move
  end
end

energy = 0
moon_array.each do |moon|
  energy += moon.total_energy
end

puts energy