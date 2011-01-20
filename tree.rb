#!/usr/bin/ruby
# File:   parsing a dbf tree and re-calculating weights	
# Author: Nikos Vasilakis	
# email:  n.c.vasilakis@gmail.com	
# comments: below is the segment object structure
# COUNT_coun, x_start, y_start, x_end, y_end, length, is_leaf, edge_id, parent, listOfChildren

require 'rubygems' # for dbf gem
require 'segment'
require 'dbf'      # gem install dbf

#TODO PREPEI NA TO TRE3W STO ROOT TOU DENTROU TO OPOIO PREPEI NA FTIA3W STHN BUILD
#TODO Synchronize array index value with edge_id ( use loadValues functio)

class Tree

  @structure

  def initialize()
    @structure = []
  end

  def load(file)
    # Synchronizing array index value with edge_id
    row1 = Segment.new(0)
    row1.loadValues(0, 0, 0, 0, 0, 0, 0)
    @structure.push(row1)
    #loading the rest of the file.
    copy1 = DBF::Table.new(file)
    copy1.each do |record|
      row_rec = Segment.new(record.attributes["COUNT_coun"]) #note: we represent COUNT_coun as weight
      row_rec.x_start=record.attributes["x_start"]
      row_rec.y_start=record.attributes["y_start"]
      row_rec.x_end=record.attributes["x_end"]
      row_rec.y_end=record.attributes["y_end"]
      row_rec.length=record.attributes["length"]
      row_rec.is_leaf=record.attributes["is_leave"] #note: is_leaf is erroneously represented as is_leave
      row_rec.edge_id=record.attributes["edge_id"]
      puts "[debug] [load] row edge id: #{row_rec.edge_id}"
      @structure.push(row_rec)
    end
  end

  def build
    str_copy = @structure.dup
    #second Iteration to find father
    @structure.each do |segment|
      str_copy.each do |segment_copy|
        #  end(i) = start(parent(i))
        if segment_copy.x_start==segment.x_end
          segment.parent=segment_copy.edge_id
        end
        # start(i) = end(children(i))
        if segment_copy.x_end==segment.x_start
          segment.addChild(segment_copy.edge_id)
        end
      end
      puts "[debug] [build] row edge id: #{segment.edge_id} with weight #{segment.weight}"
    end
  end

  # subtree = list (array) of node id's 
  # we needd subtree because we have no way of accessing a tree object 
  # within a tree -- it doesn't even exist! == problem in implementation???
  # ARA stelnw komvo pou exei olh thn plhroforia tou komvou
  #
  # PREPEI NA TO TRE3W STO ROOT TOU DENTROU TO OPOIO PREPEI NA FTIA3W STHN BUILD
  def recalc(inode)
    fullCount = 0
    puts " WTF!!!!!!!!!!"
    inode.listOfChildren.each do |node|
p node
      komvos = self.get(node)
p komvos
      if komvos.normalize==0
        puts "node #{node} is not leaf"
        # if not leaf
        #recalc(holon.searchFor(node).listOfChildren)
        self.recalc(komvos)
      else  
        # exw kanei: node.normalize kai einai leaf
        puts "node #{node} is leaf"
        
      end
      # uplogizw to sum of coun and re-normalize
      fullCount = fullCount + komvos.weight
    end
    puts " WTF!!!!!!!!!!"
    inode.weight = fullCount
  end

  # search for an edge with edge_id = index != array_index
  def searchFor(index)
    p index
    @structure.each do |node|
      if node.edge_id == index 
        return node end
    end
  end

  def getRoot
    new_struct = @structure.sort { |a, b| b.weight <=> a.weight }
    # new_struct = @structure.sort_by { |isegment| isegment.weight }
    puts "root is #{new_struct[0].edge_id} with weight #{new_struct[0].weight}"
    return new_struct[0]
  end

  # return array_index
  def get(index)
    puts "[debug] index: #{index}"
    segment = @structure[index]
    return segment
  end
end


