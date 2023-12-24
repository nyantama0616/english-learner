class V1::WordsController < ApplicationController
  def index
    min_stat_frequency = filter_params[:minStatFrequency] || 0
    limit = filter_params[:limit].to_i || 10
    
    if limit > 5000
      render json: { error: "limitは5000以下にしてください" }, status: :bad_request
      return
    end

    words = Word.where('stat_frequency >= ?', min_stat_frequency).order(stat_frequency: :desc).limit(limit)
    
    render json: { words: words.map(&:info) }
  end

  #TODO: エラーハンドリングする
  def update
    datum = update_params[:datum]

    datum.each do |data|
      id = data[:wordId]
      data = data.slice(:meaning, :reported).compact
      word = Word.find(id)
      word.update(data)
    end

    head :ok
  end

  private

  def filter_params
    params.permit(:minStatFrequency, :limit)
  end

  def update_params
    params.permit(datum: [:wordId, :meaning, :reported])
  end
end
