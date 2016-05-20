# meetup.rb

require 'date'

DAYS_OF_THE_WEEK = { 0 => :sunday, 1 => :monday, 2 => :tuesday,
  3 => :wednesday , 4 => :thursday, 5 => :friday, 6 => :saturday }
SCHEDULE = { first: 0, second: 1, third: 2, fourth: 3, last: -1 }

class Meetup
  attr_reader :month, :year

  def initialize(month, year)
    @year = year
    @month = month
    @monthly_calendar = { sunday: [], monday: [], tuesday: [], 
      wednesday: [], thursday: [], friday: [], saturday: [] }
    create_monthly_calendar
  end

  def create_monthly_calendar
    days_in_month = Date.new(year, month, -1).day

    (1..days_in_month).each do |day|
      weekday = DAYS_OF_THE_WEEK[Date.new(year, month, day).wday]
      @monthly_calendar[weekday] << day
    end
  end

  def day(weekday, schedule)
    dates = @monthly_calendar[weekday]

    if SCHEDULE.include?(schedule)
      day = dates[SCHEDULE[schedule]]
    elsif schedule == :teenth
      @monthly_calendar[weekday].each do |date|
        if date >= 13 && date <= 19
          day = date
        end
      end
    end

    Date.new(year, month, day)
  end
end
