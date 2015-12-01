require 'date'

def days_passed?(date, days)
  today = Date.parse(Time.now().to_s)
  return today >= (date + days)
end

def date_today
  return Date.parse(Time.now().to_s)
end
