class V1::ArticlesController < ApplicationController
  def index
    articles = Article.all
    render json: { articles: article_short_infos(articles) }
  end

  def show
    article = Article.find_by_id(params[:id])
    
    if article
      render json: article_info(article)
    else
      render json: { error: "Article not found" }, status: :not_found
    end
  end

  def create
    article = Article.new(article_params)
    if article.save
      render json: article_info(article), status: :created
    else
      render json: { error: "Failed to create article" }, status: :unprocessable_entity
    end
  end

  private

  def article_short_infos(articles)
    articles.map do |article|
      json = article_info(article).except("body")
    end
  end

  def article_info(article)
    json = article.as_json(only: [:id, :title, :body, :word_count])
    json.deep_transform_keys! { |key| key.camelize(:lower) }
    json
  end

  def article_params
    params.require(:article).permit(:title, :body)
  end
end
