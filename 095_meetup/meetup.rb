require 'date'

class Meetup
  TEENTH_DAYS = (13..19).freeze

  attr_accessor :date
  attr_reader :weekdays

  def initialize(month, year)
    @date = Date.new(year, month, 1)
    @weekdays = { monday: 0, tuesday: 0, wednesday: 0, thursday: 0, friday: 0, saturday: 0, sunday: 0 }
  end

  def day(weekday, descriptor)
    loop do
      current_weekday = date.strftime('%A').downcase.to_sym
      weekdays[current_weekday] += 1

      if weekday == current_weekday
        if descriptor == :last
          return date if (date + 7).month != date.month
        elsif descriptor == :teenth
          return date if TEENTH_DAYS.include?(date.day)
        else
          return date if to_ordinal(weekdays[weekday]) == descriptor
        end
      end

      self.date = date.next_day
    end
  end

  def to_ordinal(num)
    case num
    in 1 then :first
    in 2 then :second
    in 3 then :third
    in 4 then :fourth
    end
  end
end
