class School
  attr_reader :students

  def initialize
    @students = {}
  end

  def roster
    students.sort.map(&:last).flatten
  end

  def add(name, grade)
    return false if students.values.flatten.include?(name)

    if students.keys.include?(grade)
      students[grade] << name
      students[grade].sort!
    else
      students[grade] = [name]
    end
    true
  end

  def grade(number)
    students[number] || []
  end
end
