class LogLineParser
  def initialize(line)
    @line = line || ''
  end

  def message
    log_line_parts.last.strip
  end

  def log_level
    log_line_parts.first.downcase.slice(1...-1).strip
  end

  def reformat
    "#{message} (#{log_level})"
  end

  private

  def log_line_parts
    @line.split(':')
  end
end
