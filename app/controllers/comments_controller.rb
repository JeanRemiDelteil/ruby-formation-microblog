class CommentsController < ApplicationController

  # GET /articles/:article_id/comments
  def index
    # Written with access from Comment
    # comments = Comment.where(article_id: params[:article_id])

    render json: article.comments
  end

  def show
    render json: article.comments.find_by(id: params[:id])
  end

  def create
    comment = article.comments.create!(content: params[:content])

    render json: comment
  end

  # PUT /articles/:article_id/comments/:id
  def update
    comment = article.comments.find_by(id: params[:id])

    comment.content = params[:content] if params[:content]
    comment.save!

    render json: comment
  end

  def destroy
    comment = article.comments.find_by(id: params[:id])

    comment.destroy!

    head :ok
  end

  private

  def article
    @article ||= Article.find(params[:article_id])
  end
end
