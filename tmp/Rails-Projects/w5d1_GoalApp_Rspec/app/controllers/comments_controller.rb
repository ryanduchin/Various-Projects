class CommentsController < ApplicationController
  def create
    comment = Comment.new(comment_params)
    comment.author_id = current_user.id
    comment.save
    flash[:errors] = comment.errors.full_messages
    redirect_to :back
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to :back
  end

  private
    def comment_params
      params.require(:comment).permit(:body, :commentable_type, :commentable_id)
    end
end
