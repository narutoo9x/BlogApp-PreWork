class CommentsController < ApplicationController
  before_action :set_article, only: [:create, :edit, :update, :destroy]
  
  # def new
  #   @comment = Comment.new    
  # end

  def create
    # @article = Article.find(params[:article_id])
    @comment = @article.comments.create(params[:comment].permit(:comment))
    redirect_to :back
  end

  # def edit
  #   @comment = @article.comments.find(params[:id])
  # end

  # def update
  #   @comment = @article.comments.find(params[:id])
  #   if @comment.update(params[:commnet].permit(:comment))
  #     redirect_to root_path
  #   else
  #     render 'edit'
  #   end
  # end

  # def destroy
  #   @comment = @article.comments.find(params[:id])
  #   @comment.destroy
  #   redirect_to root_path
  # end
  private
  def set_article
    @article = Article.find(params[:article_id])
  end
end
