require "spec_helper"
require_relative "../world"

describe Robot do
  it "can be properly initialized with max coordinates" do
    world = World.new({:x => 5, :y => 6})
    world.max_coordinates[:x].should == 5
    world.max_coordinates[:y].should == 6
  end
end