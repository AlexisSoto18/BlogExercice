class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [ :create, :new, :edit, :update, :destroy ]
  before_action :set_article, only: [ :show, :edit, :update, :destroy ]

  def index
    @articles = Article.all
  end
  def new
    @article = Article.new
    @categories = Category.all
  end
  def create
    @article = current_user.articles.create(article_params)
    @article.save_categories
    redirect_to(articles_url)
  end
  def show
  end
  def edit
    @categories = Category.all
  end
  def update
    @article.update(article_params)
    @article.save_categories
    redirect_to(@article)
  end
  def destroy
    @article.destroy
    redirect_to articles_url
  end

  def from_author
    @user = User.find_by(id: params[:user_id])
    if @user.nil?
      redirect_to articles_path, alert: "Usuario no encontrado."
    else
      @articles = @user.articles
    end
  end

  private
  def set_article
    @article = Article.find_by(id: params[:id])
    if @article.nil?
      redirect_to articles_path
    end
  end

  def article_params
    params.require(:article).permit(:title, :content, category_elements: [])
  end
end
