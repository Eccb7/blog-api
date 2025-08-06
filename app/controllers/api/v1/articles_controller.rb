class Api::V1::ArticlesController < ApplicationController
  def index
    articles = Article.all
    render json: articles
  end

  def show
    article = Article.find_by!(slug: params[:slug])
    render json: article
  end

  def create
    article = Article.new(article_params)
    if article.save
      render json: article, status: :created
    else
      render json: article.errors, status: :unprocessable_entity
    end
  end

  def update
    article = Article.find_by!(slug: params[:slug])
    if article.update(article_params)
      render json: article
    else
      render json: article.errors, status: :unprocessable_entity
    end
  end

  def destroy
    article = Article.find_by!(slug: params[:slug])
    article.destroy
    head :no_content
  end

  def filter
    # Add filtering logic here
    render json: Article.all
  end

  private

  def article_params
    params.require(:article).permit(:title, :content, :published_at)
  end
end
