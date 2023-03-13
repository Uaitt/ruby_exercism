class LogLineParser
  def initialize(line)
    @line = line
  end

  def message
    words_array.last.strip
  end

  def log_level
    words_array.first.downcase.slice(1...-1).strip
  end

  def reformat
    "#{message} (#{log_level})"
  end

  private

  def words_array
    @line.split(':')
  end
end
