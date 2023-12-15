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
end
