class CommentsController < ApplicationController
  def index
    case
    when params[:author_id]
      comments = Comment.where(author_id: params[:author_id])
    when params[:artwork_id]
      comments = Comment.where(artwork_id: params[:artwork_id])
    else
      comments = Comment.all
    end
    render json: comments
  end

  def create
    comment = Comment.new(comment_params)
    if comment.save
      render json: comment, status: :created
    else
      render json: comment.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    render json: comment
  end

  def like
    like = Like.new(author_id: params[:user_id], likeable_id: params[:id], likeable_type: 'Comment')
    if like.save
      render json: like
    else
      render json: like.errors.full_messages, status: :unprocessable_entity
    end
  end

  def unlike
    like = Like.find_by(author_id: params[:user_id], likeable_id: params[:id], likeable_type: 'Comment')
    if like.destroy
      render json: like
    else
      render json: like.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :author_id, :artwork_id)
  end
end
