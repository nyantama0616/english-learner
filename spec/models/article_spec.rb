require 'rails_helper'

RSpec.describe Article, type: :model do

  context "create" do
    before do
      @article = FactoryBot.build(:article)
    end

    it "Factoryによるモデルの作成ができる" do
      expect(@article).to be_valid
    end

    it "titleがnilの場合、モデルの作成に失敗する" do
      @article.title = nil
      expect(@article).to be_invalid
    end

    it "titleが空文字の場合、モデルの作成に失敗する" do
      @article.title = ""
      expect(@article).to be_invalid
    end

    it "titleが256文字の場合、モデルの作成に失敗する" do
      @article.title = "a" * 256
      expect(@article).to be_invalid
    end

    it "bodyがnilの場合、モデルの作成に失敗する" do
      @article.body = nil
      expect(@article).to be_invalid
    end

    it "bodyが空文字の場合、モデルの作成に失敗する" do
      @article.body = ""
      expect(@article).to be_invalid
    end

    it "bodyが10001文字の場合、モデルの作成に失敗する" do
      @article.body = "a" * 10001
      expect(@article).to be_invalid
    end

    it "作成時にword_count=12となる" do
      @article.save!
      expect(@article.word_count).to eq(12)
    end

    it "編集時にword_count=3となる" do
      params = { body: %w[word0 word1 word2] }
      @article.save!
      @article.update!(params)
      expect(@article.word_count).to eq(3)
    end

    it "作成時にwordsがlemmatizeされて作成される" do
      @article.save!
      @article.words.each do |word|
        lemmatized = WordAnalyzer.lemmatize(word)
        expect(Word.find_by_name(lemmatized)).to be_truthy
      end
    end
  end

  context "words" do
    before do
      @article = FactoryBot.create(:article)
    end

    it "titleとbodyから単語を取得できる" do
      expected = %w[test article aa bb cc dd ee why is pandas so popular]
      expect(@article.words.sort).to eq(expected.sort)
    end

    it "titleとbodyから単語の基本形を取得できる" do
      expected = %w[test article aa bb cc dd ee why be panda so popular]
      expect(@article.basic_forms.sort).to eq(expected.sort)
    end


  end
end
