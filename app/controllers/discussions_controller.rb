class DiscussionsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  
  def index
    @project = Project.find params[:project_id]
    # @discussions = @project.discussions
    @discussion = Discussion.new
    @discussion.user = current_user
  end

  def show
    @project = Project.find params[:project_id]
    @discussion = @project.discussions.find params[:id]
    @comment = Comment.new
    @comment.user = current_user
  end

  def new
    @discussion = Discussion.new
  end

  def edit
    @project = Project.find params[:project_id]
    @discussion = Discussion.find params[:id]
  end

  def create
    @project = Project.find params[:project_id]
    @discussion = Discussion.new discussion_params
    @discussion.project = @project
    @discussion.user = current_user
    if @discussion.save
      redirect_to project_discussions_path(@project), notice: "Discussion created successfully!"
    else 
      redirect_to project_discussions_path(@project), alert: "Unable to create discussion"
    end 
  end

  def update
    @project = Project.find params[:project_id]
    @discussion = @project.discussions.find params[:id]
    if @discussion.update discussion_params
      redirect_to project_discussions_path(@project), notice: "Discussion edited successfully!"
    else 
      redirect_to project_discussions_path(@project), alert: "Unable to edit discussion"
    end
  end

  def destroy
    @project = Project.find params[:project_id]
    @discussion = Discussion.find params[:id]
    if @discussion.destroy
      redirect_to project_discussions_path(@project), notice: "Discussion deleted!"
    else
      redirect_to project_discussions_path(@project), notice: "Unable to delete discussion"
    end
  end

  private

  def discussion_params
    params.require(:discussion).permit(:title, :description, :user_id)
  end

end
