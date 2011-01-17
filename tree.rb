#!/usr/bin/ruby
# File:   parsing a dbf tree and re-calculating weights	
# Author: Nikos Vasilakis	
# email:  n.c.vasilakis@gmail.com	
# comments: below is the segment object structure
# COUNT_coun, x_start, y_start, x_end, y_end, length, is_leaf, edge_id, parent, listOfChildren

require 'rubygems' # for dbf gem
require 'segment'
require 'dbf'      # gem install dbf

def recalc(subtree)
  fullCount = 0
  subtree.each do |node|
    unless node.normalize==1
      # if not leaf
      recalc(holon.searchFor(node).listOfChildren)
    end
    # uplogizw to sum of coun and re-normalize
    fullCount = fullCount + node.weight

  end
  if node.is_leaf == 1
    node.
  end  
end
records = []
file1 = DBF::Table.new("input.dbf")
file2 = DBF::Table.new("input.dbf")
file1.each do |record|
  row_rec = Segment.new(record.attributes["COUNT_coun"])
  row_rec.x_start=record.attributes["x_start"]
  row_rec.y_start=record.attributes["y_start"]
  row_rec.x_end=record.attributes["x_end"]
  row_rec.y_end=record.attributes["y_end"]
  row_rec.length=record.attributes["length"]
  row_rec.is_leaf=record.attributes["is_leave"] #note: is_leaf is erroneously represented as is_leave
  row_rec.edge_id=record.attributes["edge_id"]
  #second Iteration to find father
  file2.each do |record2|
    #  end(i) = start(parent(i))
    if record2.attributes["x_start"]==record.attributes["x_end"]
      row_rec.parent=record2.attributes["edge_id"]
    end
    # start(i) = end(children(i))
    if record2.attributes["x_end"]==record.attributes["x_start"]
      row_rec.addChild(record2.attributes["edge_id"])
    end
  end
  records.push(row_rec)
  
end

puts " row 1 count: #{records[0].weight} and edge id: #{records[0].edge_id}"


