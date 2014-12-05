class Robot
  attr_reader :valid_bearings, :x, :y
  attr_accessor :bearing
  def initialize
    @valid_bearings = [:north,:west,:east,:south]
  end

  def orient(direction)
    if valid_bearings.include?(direction)
      @bearing = direction
    else
      raise(ArgumentError)
    end
  end

  def turn_right
    if bearing == :north
      self.bearing = :east
    elsif bearing == :east
      self.bearing = :south
    elsif bearing == :south
      self.bearing = :west
    else
      self.bearing = :north
    end
  end

  def turn_left
    if bearing == :north
      self.bearing = :west
    elsif bearing == :east
      self.bearing = :north
    elsif bearing == :south
      self.bearing = :east
    else
      self.bearing = :south
    end
  end

  def at(x, y)
    @x = x
    @y = y
  end

  def coordinates
    [x,y]
  end

  def advance
    if bearing == :north
      @y += 1
    elsif bearing == :east
      @x += 1
    elsif bearing == :south
      @y -= 1
    else
      @x -= 1
    end
  end
end


class Simulator

  def instructions(instr)
    instr.chars.map do |instr|
      if instr == 'L'
        :turn_left
      elsif instr == 'R'
        :turn_right
      elsif instr =='A'
        :advance
      end
    end
  end

  def place(robot, placement)
    robot.orient(placement[:direction])
    robot.at(placement[:x],placement[:y])
  end

  def evaluate(robot, instructs)
    instructions(instructs).map do |command|
      robot.send(command)
    end
  end
end
