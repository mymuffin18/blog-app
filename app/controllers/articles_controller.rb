class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]

  def index
    @articles = Article.includes(:user).order('id desc')
  end

  def show
    @article = Article.find(params[:id])

    @comments = @article.comments
  end

  def new
    @article = current_user.articles.build
  end

  def create
    @article = current_user.articles.build(article_params)
    if @article.save
      flash[:notice] = 'Article successfully created'
      redirect_to articles_path
    else
      flash[:alert] = 'Error processing your data'
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      flash[:notice] = 'Article was successfully updated'
      redirect_to @article
    else
      flash[:alert] = 'Something went wrong'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    flash[:notice] = 'Article Deleted'
    redirect_to articles_path, status: :see_other
  end

  private

  def article_params
    params.require(:article).permit(:title, :body, :article_image)
  end
end
