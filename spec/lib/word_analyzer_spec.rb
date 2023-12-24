require 'rails_helper'

RSpec.describe "WordAnalyzer", type: :job do
  context "lemmatize" do
    it "動詞の3人称単数" do
      expect(WordAnalyzer.lemmatize("plays", :verb),).to eq("play")
      expect(WordAnalyzer.lemmatize("goes", :verb),).to eq("go")
      expect(WordAnalyzer.lemmatize("has", :verb),).to eq("have")
      expect(WordAnalyzer.lemmatize("teaches", :verb),).to eq("teach")
      expect(WordAnalyzer.lemmatize("studies", :verb),).to eq("study")
    end
    
    it "動詞の過去形" do
      expect(WordAnalyzer.lemmatize("went", :verb),).to eq("go")
      expect(WordAnalyzer.lemmatize("was", :verb),).to eq("be")
      expect(WordAnalyzer.lemmatize("bit", :verb),).to eq("bite")
      expect(WordAnalyzer.lemmatize("bought", :verb),).to eq("buy")
      expect(WordAnalyzer.lemmatize("drew", :verb),).to eq("draw")
    end

    it "動詞の過去分詞" do
      expect(WordAnalyzer.lemmatize("understood", :verb),).to eq("understand")
      expect(WordAnalyzer.lemmatize("been", :verb),).to eq("be")
      expect(WordAnalyzer.lemmatize("bitten", :verb),).to eq("bite")
      expect(WordAnalyzer.lemmatize("bought", :verb),).to eq("buy")
      expect(WordAnalyzer.lemmatize("lent", :verb),).to eq("lend")
    end

    it "動詞の現在分詞" do
      expect(WordAnalyzer.lemmatize("understanding", :verb),).to eq("understand")
      expect(WordAnalyzer.lemmatize("being", :verb),).to eq("be")
      expect(WordAnalyzer.lemmatize("walking", :verb),).to eq("walk")
    end

    it "名詞の複数形" do
      expect(WordAnalyzer.lemmatize("teeth", :noun),).to eq("tooth")
      expect(WordAnalyzer.lemmatize("halves", :noun),).to eq("half")
      expect(WordAnalyzer.lemmatize("children", :noun),).to eq("child")
    end
  end

  context "part_of_speechs" do
    it "肯定文" do
      sentence = "We will now begin the meeting."
      tagged = WordAnalyzer.part_of_speechs(sentence)
      expect(tagged).to eq(([["we", "PRP"], ["will", "MD"], ["now", "RB"], ["begin", "VB"], ["the", "DET"], ["meeting", "NN"], [".", "PP"]]))
    end
    
    it "疑問文1" do
      sentence = "Have you seen a sea gul?"
      tagged = WordAnalyzer.part_of_speechs(sentence)
      expect(tagged).to eq([["have", "VB"], ["you", "PRP"], ["seen", "VBN"], ["a", "DET"], ["sea", "NN"], ["gul", "NN"], ["?", "PP"]])
    end

    it "疑問文2" do
      sentence = "What brings you to Japan?"
      tagged = WordAnalyzer.part_of_speechs(sentence)
      expect(tagged).to eq([["what", "WP"], ["brings", "VBZ"], ["you", "PRP"], ["to", "TO"], ["japan", "NN"], ["?", "PP"]])
    end

    it "省略形(')を含む文" do
      sentence = "It's pretty cold today, isn't it?"
      tagged = WordAnalyzer.part_of_speechs(sentence)
      expect(tagged).to eq([["it", "PRP"], ["'s", "VBZ"], ["pretty", "RB"], ["cold", "JJ"], ["today", "NN"], [",", "PPC"], ["is", "VBZ"], ["n't", "RB"], ["it", "PRP"], ["?", "PP"]])
    end

  end

  context "lemmatize_sentence" do
    it "case1" do
      sentence = "Have you seen a sea gul?"
      lemmatized = WordAnalyzer.lemmatize_sentence(sentence)
      expect(lemmatized).to eq("have you see a sea gul ?")
    end
    
    it "case2" do
      sentence = "Would you like to some cofee?"
      lemmatized = WordAnalyzer.lemmatize_sentence(sentence)
      expect(lemmatized).to eq("will you like to some cofee ?")
    end

    it "case3" do
      sentence = "My favorite subject in school is science because I enjoy learning about the natural world and conducting experiments."
      lemmatized = WordAnalyzer.lemmatize_sentence(sentence)
      expect(lemmatized).to eq("my favorite subject in school be science because i enjoy learn about the natural world and conduct experiment .")
    end

    it "case4" do
      sentence = "Our math teacher explained a complex algebraic concept in a way that made it much easier for everyone in the class to understand."
      lemmatized = WordAnalyzer.lemmatize_sentence(sentence)
      expect(lemmatized).to eq("our math teacher explain a complex algebraic concept in a way that make it much easy for everyone in the class to understand .")
    end
  end

  context "is_word?" do
    it "単語" do
      words = %w[apple banana orange]
      words.each do |word|
        expect(WordAnalyzer.is_word?(word)).to eq(true)
      end
    end

    it "単語でない" do
      words = %w[a.p, nek!o, 123, 'yes', "no", ##]
      words.each do |word|
        expect(WordAnalyzer.is_word?(word)).to eq(false)
      end
    end
  end

  context "get_basic_forms" do
    it "case1" do
      text = <<~TEXT
        Why is pandas so popular?
  
        ### What is pandas?
        Panda(giant) is "fighter" yes (no) 100 years.
      TEXT
      
      expected = %w[why be panda so popular what giant fighter yes no year]
      expect(WordAnalyzer.get_basic_forms(text).sort).to eq(expected.sort)
    end
  end
end
