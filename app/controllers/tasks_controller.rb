class TasksController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  respond_to :js, :html

  def index
    @task = Task.order(:status)
  end

  def show
    @task = Task.find params[:id]
  end

  def new
    @task = Task.new 
  end

  def edit
    @project = Project.find params[:project_id]
    @task = Task.find params[:id]
  end

  def create
    @project = Project.find params[:project_id]
    @task = @project.tasks.new task_params
    @task.status = false
    @task.user = current_user
    if @task.save
      respond_with ()
      #redirect_to @project, notice: "Task created successfully!"
    else
      respond_with ()
      #redirect_to @project, alert: "Error in creating your task"
    end
  end

  def update
    @project = Project.find params[:project_id]
    @task = @project.tasks.find params[:id]
    if @task.update task_params
      redirect_to project_path(@project), notice: "Task edited successfully!"
    else
      redirect_to project_path(@project), alert: "Unable to edit task"
    end
  end

  def destroy
    @project = Project.find params[:project_id]
    @task = Task.find params[:id]
    if @task.destroy
      respond_with ()
      #redirect_to project_path(@project), notice: "Task Abolished!"
    else
      respond with ()
    end
  end

  def toggle_status
    @task = Task.find params[:id]
    if @task.status == false && @task.user != current_user
      TaskMailer.delay.notify_task_owner(@task)
      @task.status = true
    elsif @task.status == false
      @task.status = true
    elsif @task.status == true
      @task.status = false
    end
    @task.save
    respond_with ()
    #redirect_to project_path(@task.project_id)
  end

  private

  def task_params
    params.require(:task).permit([:title, :due_date])
  end

end
