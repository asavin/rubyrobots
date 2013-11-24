require "spec_helper"
require_relative "../robot"
require_relative "../world"

describe "Robot in the World" do
  it "can navigate in the world" do
    robot = Robot.new({:x => 1, :y => 2, :orientation => 'N'}, 'RFFLF')
    world = World.new({:x => 5, :y => 6})
    robot.calculate_position(world)
    robot.position.should == {:x => 3, :y => 3, :orientation => 'N'}
  end
  
  it "can be lost and leave a scent" do
    robot = Robot.new({:x => 1, :y => 2, :orientation => 'N'}, 'LFFFFFFF')
    world = World.new({:x => 5, :y => 6})
    robot.calculate_position(world)
    robot.position.should == {:x => 0, :y => 2, :orientation => 'W', :lost => true}
    last_position = robot.position
    last_position.delete(:lost)
    world.robot_scent_array.should include(last_position)
  end
  
  it "can create two different robots" do
    robot = Robot.new({:x => 11, :y => 22, :orientation => 'W'}, 'LFFRRR')
    robot2 = Robot.new({:x => 1, :y => 2, :orientation => 'N'}, 'LFFFFFFF')
    
    robot.position.should == {:x => 11, :y => 22, :orientation => 'W'}
    robot.command_sequence.should == 'LFFRRR'
    robot2.position.should == {:x => 1, :y => 2, :orientation => 'N'}
    robot2.command_sequence.should == 'LFFFFFFF'
  end
  
  it "can warn other robots, and they will avoid danger" do
    robot = Robot.new({:x => 1, :y => 2, :orientation => 'N'}, 'LFFFFFFF')
    robot2 = Robot.new({:x => 1, :y => 2, :orientation => 'N'}, 'LFFFFFFF')
    world = World.new({:x => 5, :y => 6})
    robot.calculate_position(world)
    robot2.calculate_position(world)
    
    robot2.position.should == {:x => 0, :y => 2, :orientation => 'W'}
    robot2.position[:lost].should be_nil
  end
end