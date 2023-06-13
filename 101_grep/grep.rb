class Grep
  LINE_COUNT_FLAG = '-n'.freeze
  FILE_NAME_FLAG = '-l'.freeze
  CASE_INSENSITIVE_FLAG = '-i'.freeze
  INVERSE_MATCH_FLAG = '-v'.freeze
  ENTIRE_LINE_FLAG = '-x'.freeze

  attr_accessor :pattern, :matches, :lines, :formatted_line, :formatted_line_number, :formatted_file_name
  attr_reader :flags, :file_names

  class << self
    def grep(pattern, flags, file_names)
      new(pattern, flags, file_names).grep
    end
  end

  def initialize(pattern, flags, file_names)
    @pattern = pattern
    @flags = flags
    @file_names = file_names
    @matches = []
  end

  def grep
    file_names.each { |file_name| search_for(file_name) }
    matches.join.strip
  end

  private

  def search_for(file_name)
    self.lines = File.readlines(file_name)
    lines.each_with_index do |line, index|
      format_line(line)
      next unless line_matches?
      return matches << "#{file_name}\n" if flags.include?(FILE_NAME_FLAG)

      format_line_number(index)
      format_file_name(file_name)

      matches << "#{formatted_file_name}#{formatted_line_number}#{line}"
    end
  end

  def format_line(line)
    if flags.include?(CASE_INSENSITIVE_FLAG)
      self.pattern = pattern.downcase
      self.formatted_line = line.downcase
    else
      self.formatted_line = line
    end
  end

  def line_matches?
    if flags.include?(INVERSE_MATCH_FLAG)
      !formatted_line.include?(pattern)
    elsif flags.include?(ENTIRE_LINE_FLAG)
      formatted_line.strip == pattern
    else
      formatted_line.include?(pattern)
    end
  end

  def format_line_number(index)
    self.formatted_line_number = flags.include?(LINE_COUNT_FLAG) ? "#{index + 1}:" : ''
  end

  def format_file_name(file_name)
    if file_names.length == 1
      self.formatted_file_name = ''
    else
      self.formatted_file_name = "#{file_name}:" unless file_name.include?(':')
    end
  end
end
