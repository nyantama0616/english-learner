class WordAnalyzer
  @@lemmatizer = Lemmatizer.new
  class << self
    # 英単語をlemmatizeする関数
    def lemmatize(word, pos = nil)
      @@lemmatizer.lemma(word, pos)
    end
  end
end
