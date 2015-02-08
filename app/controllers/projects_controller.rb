class ProjectsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  
  def new
    @project = Project.new
  end

  def create
    @project = Project.new project_params
    @project.user = current_user
    if @project.save
      redirect_to projects_path
    else 
      render new_project_path, notice: "Did you remember to include a Title for your project?"
    end
  end

  def update
    @project = Project.find params[:id]
    if @project.update project_params
      redirect_to project_path
    else
      render edit_project_path
    end
  end

  def edit
    @project = Project.find params[:id]
  end

  def destroy
    @project = Project.find params[:id]
    @project.destroy
    redirect_to projects_path
  end

  def index
    @projects = Project.order(:title)
    if params[:search]
      @projects = Project.search(params[:search]).order(:title)
    else
      @projects = Project.all.order(:title)
    end
  end

  def show
    @project = Project.find params[:id]
    @projects = Project.order params[:title]
    @task = Task.new
    @discussion = Discussion.new
    @tasks = @project.tasks.order(:status)
    @favourite = current_user.favourite_for(@project)
  end

  def favourite
    @projects = Project.find(current_user.favourites.map(&:project_id))
  end

  def project_params
    params.require(:project).permit([:title, :description, :due_date, {user_ids: []},
                                                                      {tag_ids: []}])
  end

end

