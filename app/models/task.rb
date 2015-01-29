class Task < ActiveRecord::Base
  
  # Associations

  belongs_to :user

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



end
