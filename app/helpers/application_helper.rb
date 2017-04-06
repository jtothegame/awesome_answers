module ApplicationHelper

  def standard_date_format(date)
    date.strftime('%Y-%B-%d')
  end
end
