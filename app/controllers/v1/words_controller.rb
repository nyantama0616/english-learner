class V1::WordsController < ApplicationController
  def index
    min_stat_frequency = filter_params[:min_stat_frequency] || 0
    limit = filter_params[:limit].to_i || 10
    
    if limit > 5000
      render json: { error: "limitは5000以下にしてください" }, status: :bad_request
      return
    end

    words = Word.where('stat_frequency >= ?', min_stat_frequency).order(stat_frequency: :desc).limit(limit)
    
    render json: { words: word_infos(words) }
  end

  private

  def word_infos(words)
    words.map do |word|
      json = word.as_json(only: [:id, :name, :meaning, :stat_frequency])
      json["word"] = json.delete("name")
      json
    end
  end

  def filter_params
    params.permit(:min_stat_frequency, :limit)
  end
end
