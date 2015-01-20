class PagesController < ApplicationController
 

  def home
  	redirect_to task_path(current_user) if current_user
  end


end
