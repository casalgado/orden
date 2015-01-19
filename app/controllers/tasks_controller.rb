class TasksController < ApplicationController
  def new
  end

  def create
  end

  def show
    @tasks = current_user.tasks.where(:due_date => Date.today.beginning_of_day..Date.today.end_of_day)
  end

  def index
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
