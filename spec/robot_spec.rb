require "spec_helper"
require_relative "../robot"

describe Robot do
  it "can be properly initialized with initial position" do
    robot = Robot.new({:x => 1, :y => 2, :orientation => 'E'}, {})
    robot.start_position[:x].should == 1
    robot.start_position[:y].should == 2
    robot.start_position[:orientation].should == 'E'
  end
  
  it "can be properly initialized with command sequence" do
    robot = Robot.new({:x => 1, :y => 2, :orientation => 'E'}, 'RFRFRRLFF')
    robot.command_sequence.should == 'RFRFRRLFF'
  end
end