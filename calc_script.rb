#!/usr/bin/ruby
# File:   calc_script.rb does the actual work  
# Author: Nikos Vasilakis  
# email:  n.c.vasilakis@gmail.com  

require "tree"
    

#if (node.is_leaf == 1)
#node.
#end  


holon = Tree.new
holon.load("input.dbf")
holon.build
puts "--------"
root = holon.getRoot
puts "--------"

puts " row 0 count: #{holon.get(0).weight} and edge id: #{holon.get(0).edge_id}"
puts " row 1 count: #{holon.get(1).weight} and edge id: #{holon.get(1).edge_id}"
#puts " row 1 count: #{records[0].weight} and edge id: #{records[0].edge_id}"

holon.recalc(root)
puts " row 0 count: #{holon.get(0).weight} and edge id: #{holon.get(0).edge_id}"
puts " row 1 count: #{holon.get(1).weight} and edge id: #{holon.get(1).edge_id}"
puts "--------"
holon.getRoot
puts "--------"


