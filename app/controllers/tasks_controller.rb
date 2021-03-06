class TasksController < ApplicationController
  def new
  end

  def create
    @task = Task.new(task_params)
    @task.save
    redirect_to tasks_path(current_user)
  end

  def show
    @task = Task.find(params[:id])
  end

  def complete
    @task = Task.find(params[:task_id])
    @task.update(complete: !@task.complete)
    redirect_to tasks_path
  end

  def index
    @footer = false
    @task  = Task.new
    @tasks = current_user.tasks.incomplete.order("due_date ASC")
    gon.tasks = Task.for_calendar(@tasks)
  end

  def completed
    @tasks = current_user.tasks.completed.order("name ASC")
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    @task.update!(task_params)
    redirect_to tasks_path
  end

  def destroy
  end

  private

  def task_params
    params.require(:task).permit(:name, :user_id, :due_date, :complete)
  end
end
