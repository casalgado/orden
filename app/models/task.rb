class Task < ActiveRecord::Base
  
  # Associations

  belongs_to :user

  # Callbacks

  before_create :interpret_string

  # Scopes

  scope :completed,  -> { where(complete: true)  }
  scope :incomplete, -> { where(complete: false) }
  scope :by_day, (lambda do |date| 
                      bod = date.beginning_of_day
                      eod = date.end_of_day
                      where("due_date >= ? and due_date <= ?", bod, eod)
                   end)

  # Methods


  # Returns array of tasks that fullcalendar can interpret.
  def self.for_calendar(array)
    array.map! { |task| task.to_event_format }
  end

  # Converts to event_format to be read by full_calendar.
  def to_event_format
    new_time = self.due_date + 3600
    event = {title: self.name, start: self.due_date, end: new_time, backgroundColor: '#88c656', borderColor: '#88c656'}
  end

  # Determies if and by how many days a task is overdue.
  def status
  	(Date.today - due_date.to_date).to_i
  end

  # Returns status as a string to be used by display_task helper.
  def status_class
    if status >= 3
      "danger" 
    elsif status == 2
      "warning"
    elsif status == 1
      "info"
    end 
  end

  # private -- tests not working when methods below are private. 

  def interpret_string
    string_input      = self.name.split(" ")
    values_to_convert = []
    self.name.split(" ").each do |key|
      if key[0] == "."
        values_to_convert << key[1..-1]
        string_input.delete(key)
      end
    end
    self.due_date = to_time(values_to_convert)
    self.name     = string_input.join(" ").capitalize
  end

  def to_time values_to_convert # returns time object
    date = Date.today
    time = [Time.zone.now.hour, Time.zone.now.min]
    values_to_convert.each do |key|
      if key.to_i == 0
        date = key_to_date(key)
      else
        time = key_to_time(key)
      end
    end
    Time.new(date.year, date.mon, date.mday, time[0], time[1], 00)
  end

  def key_to_date key # returns date object
    wday_array = ['d', 'l', 'm', 'c', 'j', 'v', 's']
    wday = wday_array.index(key[0])
    increment = wday + ( 7 * (key.length - 1) ) - Date.today.wday 
    increment += 7 if wday <= Date.today.wday
    next_day  = Date.today + increment
  end

  def key_to_time key # returns array
    key += "00" if key.to_i < 100
    [key[0..-3].to_i, key[-2..-1].to_i]
  end



end
