require "spec_helper"
require_relative "../robot"

describe Robot do
  it "can be properly initialized with initial position" do
    robot = Robot.new({:x => 1, :y => 2, :orientation => 'E'}, '')
    robot.position[:x].should == 1
    robot.position[:y].should == 2
    robot.position[:orientation].should == 'E'
  end
  
  it "can be properly initialized with command sequence" do
    robot = Robot.new({:x => 1, :y => 2, :orientation => 'E'}, 'RFRFRRLFF')
    robot.command_sequence.should == 'RFRFRRLFF'
  end
  
  it "fails wrong command sequence" do
    robot = Robot.new({:x => 1, :y => 2, :orientation => 'E'}, 'RFRFRGGRLFF')
    robot.command_sequence.should be_nil
  end
  
  it "validates commands when entered in both lower and uppercase" do
    robot = Robot.new({:x => 1, :y => 2, :orientation => 'E'}, 'lrlrlrlfffRF')
    robot.command_sequence.should == 'LRLRLRLFFFRF'
  end
  
  
end