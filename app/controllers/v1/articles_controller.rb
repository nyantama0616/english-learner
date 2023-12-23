class V1::ArticlesController < ApplicationController
  def index
    articles = Article.all
    render json: { articles: article_short_infos(articles) }
  end

  def show
    article = Article.find(params[:id])
    
    if article
      render json: article_info(article)
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
end
