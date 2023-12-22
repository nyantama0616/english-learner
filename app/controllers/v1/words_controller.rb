class V1::WordsController < ApplicationController
  def index
    words = Word.order(:name).limit(100)
    
    render json: { words: word_infos(words) }
  end

  private

  def word_infos(words)
    words.map do |word|
      json = word.as_json(only: [:id, :name, :meaning])
      json["word"] = json.delete("name")
      json
    end
  end
end
