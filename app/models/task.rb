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


  # Determies if and by how many days a task is overdue. 
  def status
  	num = Date.today.day - self.due_date.day
  	if num == 3
  		"danger" 
  	elsif num == 2
  		"warning"
  	elsif num == 1
  		"info"
  	else
  		nil
  	end 
  end

  private

  def interpret_string
    interpret = []
    wday_array = ['d', 'l', 'm', 'c', 'j', 'v', 's']
    array = self.name.split(" ")
    dupli = array.dup
    array.each do |element|
      if element[0] == "."
        interpret << element[1..-1]
        dupli.delete(element)
      end
    end

    interpret.each do |element|
    if element.to_i == 0
      wday_array.each_with_index do |letter, index|
        element.gsub!(letter, "#{index}")
      end
      element = element.to_s
      if element.length > 1
        increment = element[0].to_i + ( 7 * (element.length - 1) )
      else
        increment = element.to_i
      end
      next_day = Date.today + increment - Date.today.wday # solo funciona para wday > Date.today.wday
      @date_string = "#{next_day.year}-#{next_day.mon}-#{next_day.day}"
    else
      if element.to_i < 100
        @time_string = element + ":00:00"
      else
        @time_string = element[0..-3] + ":" + element[-2..-1] + ":00"
      end
    end
  end
  new_date = @date_string + " " + @time_string
  self.due_date = new_date
  self.name = dupli.join(" ").capitalize
  end



end
