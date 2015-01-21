class Task < ActiveRecord::Base
  
  # Associations

  belongs_to :user

  # Scopes

  scope :completed,  -> { where(complete: true)  }
  scope :incomplete, -> { where(complete: false) }

  # Methods

  def status
  	num = Date.today.day - self.due_date.day
  	if num == 3
  		"danger" 
  	elsif num == 2
  		"warning"
  	else
  		"info"
  	end 
  end

end
