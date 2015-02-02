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
  	days.uniq
  end

  def agenda_hash
    hash = Hash.new
    days_with_tasks.sort.each do |day|
      if day <= Date.today
        hash[Date.today.strftime("%A %-d %b")] = []
      else
        hash[day.strftime("%A %-d %b")] = []
      end
    end
    tasks.incomplete.order('due_date asc').each do |task|
      if task.due_date <= Date.today
        hash[Date.today.strftime("%A %-d %b")] << task
      else
        hash[task.due_date.strftime("%A %-d %b")] << task
      end
    end
    hash
  end

end
