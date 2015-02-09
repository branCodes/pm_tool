class FavouritesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_project

  def index
  end

  def create
  @project = Project.find params[:project_id]
  @favourite = @project.favourites.new
  @favourite.user = current_user
    if @favourite.save 
      redirect_to @project, notice: "You have favourited this project!"
    else
      redirect_to @project, alert: "Error! You were unable to favourite this project!"
    end
  end

  def destroy 
    @favourite = current_user.favourites.find(params[:id])
    if @favourite.destroy
      redirect_to @project, notice: "You have unfavourited this project!"
    else
      redirect_to @project, alert: "Error! Unable to unfavourite this project!"
    end
  end

  def find_project
    @project = Project.find params[:project_id]
  end

end
