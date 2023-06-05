class CommentsController < ApplicationController
  
  def new
    @article = Article.find(params[:article_id])
		@comment = Comment.new
	end

  def create
		@user = User.find(params[:user_id])
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
		# @comment.article_id = @article.id
		# @comment.user_id = current_user.id

    if @comment.save 
      redirect_to user_article_path(@user, @article), notice: 'Комментарий успешно добавлен!'
    else
      flash.now[:alert] = 'Произошла ошибка'

      render :new
    end
  end

  def destroy
		@comment = Comment.find(params[:id])
		@comment.destroy

    article = Article.find(params[:article_id])
    user = User.find(params[:user_id])

		redirect_to user_article_path(user, article), notice: 'Комментарий удален!'
	end

  private
    def comment_params
      params.require(:comment).permit(:body)
    end
end
