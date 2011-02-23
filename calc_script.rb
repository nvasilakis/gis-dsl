#!/usr/bin/ruby
# File:   calc_script.rb does the actual work  
# Author: Nikos Vasilakis  
# email:  n.c.vasilakis@gmail.com  

require "tree"
    

#if (node.is_leaf == 1)
#node.
#end  


tree = Tree.new
tree.load("input.dbf")
tree.build
puts "--------"
root = tree.get_root
puts "--------"

puts " row 0 count: #{tree.get(0).weight} and edge id: #{tree.get(0).edge_id}"
puts " row 1 count: #{tree.get(1).weight} and edge id: #{tree.get(1).edge_id}"
#puts " row 1 count: #{records[0].weight} and edge id: #{records[0].edge_id}"

tree.recalculate(root)
puts " row 0 count: #{tree.get(0).weight} and edge id: #{tree.get(0).edge_id}"
puts " row 1 count: #{tree.get(1).weight} and edge id: #{tree.get(1).edge_id}"
puts "--------"
tree.get_root
puts "--------"


