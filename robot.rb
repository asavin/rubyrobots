class Robot
  attr_accessor :start_position, :final_position, :command_sequence
  
  def initialize(start_position, command_sequence)
    self.start_position = start_position
    self.command_sequence = command_sequence
  end
end