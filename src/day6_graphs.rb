require 'rgl/adjacency'
require 'rgl/bidirectional'
require 'rgl/traversal'
require 'rgl/dijkstra'
require 'rgl/dot'
graph = RGL::DirectedAdjacencyGraph.new


values = File.readlines('../data/day6.txt')
edge_weights = {}

values.each do |value|
  splitted = value.strip.split(')')
  sym = splitted[0].to_sym
  planet = splitted[1].to_sym

  edge_weights[[sym, planet]] = 1
  graph.add_edge sym,planet
end

puts edge_weights
puts graph.to_s
to_san = graph.dijkstra_shortest_path(edge_weights,:COM,:SAN)
to_you = graph.dijkstra_shortest_path(edge_weights,:COM,:YOU)

commons = to_san & to_you
all = to_san.union(to_you)
puts (all - commons).length - 2 
# graph.print_dotted_on
