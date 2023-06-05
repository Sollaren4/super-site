class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
    @user = User.find(params[:user_id])
  end

  def new
    @user = User.find(params[:user_id])
    @article = Article.new
  end

  def create
    # @article = Article.find(params[:article_id])
    # @comment = @article.comments.create(comment_params)
    # redirect_to article_path(@article)

    @user = User.find(params[:user_id])
    @article = @user.articles.create(article_params)
    @article.user_id = current_user.id

    if @article.save
      redirect_to user_article_path(@user, @article), notice: 'Новый пост создан!'
    else
      render :new, status: :unprocessable_entity, notice: 'ошибка'
    end
  end

  def edit
    @user = User.find(params[:user_id])
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])
		@article.destroy

		redirect_to questions_path, notice: 'Вопрос удален!'
  end

  private
    def article_params
      params.require(:article).permit(:title, :body, :user_id)
    end
end

