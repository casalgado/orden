class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :tasks

  # Returns an array of days where user has tasks. 
  def days_with_tasks
  	days = []
  	self.tasks.incomplete.each do |task|
  		days << task.due_date.to_date
  	end	
  	days.uniq!
  end

end
