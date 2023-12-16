class WordAnalyzer
  @@tagger = EngTagger.new

  class << self
    # 英単語をlemmatizeする関数
    def lemmatize(word, pos = nil)
      @@lemmatizer.lemma(word, pos)
    end

    # 英文を品詞解析する関数(動詞と名詞のみ. それ以外はnilを返す)
    @@verbs = ["VB", "VBD", "VBG", "VBN", "VBP", "VBZ"]
    @@nouns = ["NN", "NNS", "NNP", "NNPS"]
    @@adjs = ["JJ", "JJR", "JJS"]
    @@advs = ["RB", "RBR", "RBS", "MD"]
    def part_of_speechs(sentence)
      tagged = @@tagger.get_readable(sentence.downcase).split(" ").map { |word| word.split("/") }
    end
  end
end
