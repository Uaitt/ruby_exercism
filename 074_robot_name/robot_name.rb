class Robot
  PREDECESSOR_OF_STARTING_CODE = 'Z999'.freeze

  class << self
    def forget
      @current_name = PREDECESSOR_OF_STARTING_CODE
    end

    attr_accessor :current_name
  end

  def name
    @name ||= Robot.current_name = Robot.current_name.next
  end

  def reset
    @name = nil
  end
end
