require "spec_helper"
require_relative "../world"

describe Robot do
  it "can be properly initialized with max coordinates" do
    world = World.new({:x => 5, :y => 6})
    world.max_coordinates[:x].should == 5
    world.max_coordinates[:y].should == 6
  end
  
  it "will return false on initialization when out of bound dimensions provided" do
    world = World.new({:x => 55, :y => 66})
    world.max_coordinates.should be_nil
  end
  
  it "doesn't accept 0 0 as max coordinates" do
    world = World.new({:x => 0, :y => 0})
    world.max_coordinates.should be_nil
  end
  
  it "doesn't accept negative values as max coordinates" do
    world = World.new({:x => -1, :y => 10})
    world.max_coordinates.should be_nil
    
    world = World.new({:x => 1, :y => -10})
    world.max_coordinates.should be_nil
  end
end