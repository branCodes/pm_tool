class CommentsController < ApplicationController 
  respond_to :js

  def index
    @discussion = Discussion.find params[:discussion_id]
  end

  def new
    @comment = Comment.new
  end

  def create
    @project = Project.find params[:project_id]
    @discussion = Discussion.find params[:discussion_id]
    @comment = @discussion.comments.create(comment_params)
    @comment.user = current_user
    # @comment.discussion_id = @discussion.id
    if @comment.save && @discussion.user != current_user
      respond_with ()
      DiscussionMailer.delay.notify_discussion_owner(@comment)
      #redirect_to project_discussion_path(@discussion.project, @discussion), notice: "Comment Created!"
    elsif @comment.save
      respond_with ()
      #redirect_to project_discussion_path(@discussion.project, @discussion), notice: "Comment Created!"
    else
      #redirect_to project_discussion_path(@discussion.project, @discussion), notice: "Comments cannot be blank!"
      respond_with ()
    end
  end

  def comment_params
    params.require(:comment).permit([:body])
  end

  def destroy
    @project = Project.find params[:project_id]
    @discussion = Discussion.find params[:discussion_id]
    @comment = Comment.find params[:id]
    if @comment.destroy
      respond_with ()
    else #redirect_to project_discussion_path(@discussion.project, @discussion), notice: "Comment Abolished!"
      respond_with ()
    end
  end

  def edit
    @project = Project.find params[:project_id]
    @discussion = Discussion.find params[:discussion_id]
    @comment = Comment.find params[:id]
  end

  def update
    @discussion = Discussion.find params[:discussion_id]
    @comment = @discussion.comments.find params[:id]
    if @comment.update(comment_params)
    redirect_to project_discussion_path(@discussion.project, @discussion), notice: "Comment edited successfully"
    end
  end

    # if @project.task.update task_params
    #   redirect_to project_task_path(@project,@task), notice: "Task updated successfully"
    # else
    #   render :edit
    # end

  def comment_params
    params.require(:comment).permit(:body)
  end

end
