class DiscussionsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def new
    @discussion = Discussion.new
  end

  def create
    @project = Project.find params[:project_id]
    @discussion = Discussion.new discussion_params
    @discussion.project = @project
    @discussion.user = current_user
    @discussion.save
    # @project.discussions.create(discussion_params)
    redirect_to project_discussions_path(@project), notice: "Discussion created successfully"
  end

  def update
    @project = Project.find params[:project_id]
    @discussion = @project.discussions.find params[:id]
    if @discussion.update discussion_params
      redirect_to project_discussions_path(@project), notice: "Discussion edited successfully"
    end
  end

  def edit
    @project = Project.find params[:project_id]
    @discussion = Discussion.find params[:id]
  end

  def destroy
    @project = Project.find params[:project_id]
    @discussion = Discussion.find params[:id]
    @discussion.destroy
    redirect_to project_discussions_path(@project), notice: "Discussion deleted!"
  end

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

  def discussion_params
    params.require(:discussion).permit(:title, :description, :user_id)
  end

end
