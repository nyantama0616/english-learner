require 'rails_helper'

RSpec.describe "V1::Words", type: :request do
  describe "GET /index" do
    before do
      FactoryBot.create_list(:word, 10)
      @limit = 5
      @min_stat_frequency = 1.5
      get v1_words_path, params: { limit: @limit, minStatFrequency: @min_stat_frequency }
      @words = JSON.parse(response.body)["words"]
    end

    describe "適切なパラメータを渡した場合" do
      it "200返ってくる" do
        expect(response).to have_http_status(200)
      end

      it "レスポンス形式が正しい" do
        expected = ["id", "word", "meaning", "statFrequency", "reported"].sort
        expect(@words[0].keys.sort).to eq(expected)
      end
      
      it "単語がlimitで指定した数以下返ってくる" do
        expect(@words.length).to be <= @limit
      end

      it "stat_frequencyが全てmin_stat_frequency以上" do
        @words.each do |word|
          expect(word["statFrequency"]).to be >= @min_stat_frequency
        end
      end
    end
  end
  
  before do
    @limit = 5001
    get v1_words_path, params: { limit: @limit, minStatFrequency: @min_stat_frequency }
  end

  describe "5000より大きいlimitを指定した場合" do
    it "400返ってくる" do
      expect(response).to have_http_status(400)
    end

    it "エラーメッセージが返ってくる" do
      expect(JSON.parse(response.body)["error"]).to eq("limitは5000以下にしてください")
    end
  end

  describe "PATCH /words" do
    before do
      @words_old = FactoryBot.create_list(:word, 3)
      @datum = @words_old.map do |word|
        {
          #TODO: いずれかのparamsがnilだった場合のテストを書く
          wordId: word.id,
          meaning: "new meaning",
          reported: true
        }
      end
      patch "/v1/words", params: { datum: @datum }
      @words_new = @words_old.map { |word| Word.find(word.id) }
    end

    describe "適切なパラメータを渡した場合" do
      it "200返ってくる" do
        expect(response).to have_http_status(200)
      end

      it "空のレスポンスが返ってくる" do
        expect(response.body).to eq("")
      end
      
      it "meaningが更新されている" do
        @words_new.each do |word|
          expect(word.meaning).to eq("new meaning")
        end
      end

      it "reportedが更新されている" do
        @words_new.each do |word|
          expect(word.reported).to eq(true)
        end
      end
    end
  end
end
