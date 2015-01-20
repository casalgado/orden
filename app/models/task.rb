class Task < ActiveRecord::Base
  
  # Associations

  belongs_to :user

  # Scopes

  scope :completed,  -> { where(complete: true)  }
  scope :incomplete, -> { where(complete: false) }

end
