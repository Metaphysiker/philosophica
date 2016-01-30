module CalendarHelper
  def calendar(date = Date.today, &block)
    Calendar.new(self, date, block).table
  end

  def actualmonth(date)

    @eventsmonth = Event.where('extract(month from date) = ?', date.month)
  end
end