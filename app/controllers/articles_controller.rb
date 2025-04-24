class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [ :create, :new, :edit, :update, :destroy ]
  before_action :set_article, only: [ :show, :edit, :update, :destroy ]

  def index
    @articles = Article.all
  end
  def new
    @article = Article.new
  end
  def create
    @article = current_user.articles.build(article_params)
    @article.save ? redirect_to(articles_url) : render(:new)
  end
  def show
  end
  def edit
  end
  def update
    @article.update(article_params) ? redirect_to(@article) : render(:edit)
  end
  def destroy
    @article.destroy
    redirect_to articles_url
  end

  private
  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :content)
  end
end
