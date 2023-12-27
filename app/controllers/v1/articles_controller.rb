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
  
  def update
    article = Article.find_by_id(params[:id])

    unless article
      render json: { error: "Article not found" }, status: :not_found
      return
    end

    if article.update(article_params)
      render json: article_info(article)
    else
      render json: { error: "Failed to update article" }, status: :unprocessable_entity
    end
  end

  def word_dict
    article = Article.find_by_id(params[:article_id])

    unless article
      render json: { error: "Article not found" }, status: :not_found
      return
    end

    words = article.words.map do |word_name|
      lemmatized = WordAnalyzer.lemmatize(word_name)
      word = Word.find_by_name(lemmatized)
      word ? [word_name, word.info] : nil
    end

    res = words.compact.to_h
    render json: { words: res}
  end

  def words
    article = Article.find_by_id(params[:article_id])

    unless article
      render json: { error: "Article not found" }, status: :not_found
      return
    end

    res = article.basic_forms.map do |word_name|
      word = Word.find_by_name(word_name)
      
      if word
        word.info
      else
        nil
      end
    end

    res.compact!
    
    render json: { words: res }
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
    params.require(:article).permit(:title, :body).compact
  end
end
