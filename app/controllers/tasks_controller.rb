class TasksController < ApplicationController
  def new
  end

  def create
    @task = Task.new(task_params)
    @task.save
    redirect_to task_path(current_user)
  end

  def show
    @footer = false
    @task  = Task.new
    @tasks = current_user.tasks
    #current_user.tasks.where(:due_date => Date.today.beginning_of_day..Date.today.end_of_day)
  end

  def index
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def task_params
    params.require(:task).permit(:name, :user_id, :due_date)
  end
end
