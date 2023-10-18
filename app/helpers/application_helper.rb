# Application helper
module ApplicationHelper
  require 'time'

  def convert_time(date_string)
    date = Time.parse(date_string)
    date.strftime('%d/%m/%Y à %Hh%M')
  end

end
