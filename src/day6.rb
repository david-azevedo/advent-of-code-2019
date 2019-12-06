values = File.readlines('../data/day6.txt')

$planets_to_orbits = {}

def count_below_orbits(planet)
  uniques = $planets_to_orbits[planet]
  index = 0
  while uniques.length != index do
    curr = uniques[index]
    if $planets_to_orbits[curr]
      new_planets = $planets_to_orbits[curr]
      uniques = uniques.union(new_planets)
    end
    index += 1
  end
  uniques
end

values.each do |value|
  splitted = value.strip.split(')')
  sym = splitted[0].to_sym
  planet = splitted[1].to_sym

  if $planets_to_orbits[sym]
    $planets_to_orbits[sym].push(planet) unless $planets_to_orbits[sym].include? planet
  else
    $planets_to_orbits[sym] = [planet]
  end
end

orbits = 0

$planets_to_orbits.keys.each do |planet|
  orbits += count_below_orbits(planet).length
end

puts orbits
