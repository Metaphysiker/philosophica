require 'active_support/core_ext/date'
require 'active_support/core_ext/time'
require 'active_support/core_ext/array'

class Calendar
  def initialize(date=Date.today)
    @date = date
  end

  def to_a
    CalendarWeeks.new(@date).to_a.map do |week|
      week.map do |date|
        date
      end
  end
end

class CalendarWeeks
  def initialize(date=Date.today)
    @date = date
  end

  def today
    (first_calendar_day..last_calendar_day.to_a.in_groups_of(7)
  end

  private

  def first_calendar_day
    @date.beginning_of_month.beginning_of_week(:sunday)
  end

  def last_calendar_day
    @date.end_of_month.end_of_week(:sunday)
  end
end
