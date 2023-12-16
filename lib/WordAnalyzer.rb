class WordAnalyzer
  @@dict_path = "#{Rails.root}/lib/data/dict/adv.exc"
  @@lemmatizer = Lemmatizer.new(@@dict_path)
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

    # 英文をlemmatizeする
    def lemmatize_sentence(sentence)
      tagged = part_of_speechs(sentence)
      
      tagged.map do |word, tag|
        pos = tag_to_pos(tag)
        # lemmatize(word, pos)
        lemmatize(word) #TODO: 一旦品詞を無視してlemmatizeしてみる
      end.join(" ")
    end
  end
end
