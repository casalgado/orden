class TasksController < ApplicationController
  def new
  end

  def create
    @task = Task.new(task_params)
    @task.save
    redirect_to task_path(current_user)
  end

  def show
    @task = Task.find(params[:id])
  end

  def complete
    @task = Task.find(params[:task_id])
    @task.update(complete: !@task.complete)
    redirect_to task_path(current_user)
  end

  def index
    @footer = false
    @task  = Task.new
    @tasks = current_user.tasks.incomplete.order("due_date ASC")
  end

  def completed
    @tasks = current_user.tasks.completed.order("name ASC")
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def task_params
    params.require(:task).permit(:name, :user_id, :due_date, :complete)
  end
end
