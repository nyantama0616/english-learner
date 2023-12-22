require 'rails_helper'

RSpec.describe "V1::Words", type: :request do
  describe "GET /index" do
    before do
      @limit = 100
      @min_stat_frequency = 2.0
      get v1_words_path, params: { limit: @limit, min_stat_frequency: @min_stat_frequency }
      @words = JSON.parse(response.body)["words"]
    end

    describe "適切なパラメータを渡した場合" do
      it "200返ってくる" do
        expect(response).to have_http_status(200)
      end

      it "レスポンス形式が正しい" do
        expected = ["id", "word", "meaning", "stat_frequency"].sort
        expect(@words[0].keys.sort).to eq(expected)
      end
      
      it "単語がlimitで指定した数以下返ってくる" do
        expect(@words.length).to be <= @limit
      end

      it "stat_frequencyが全てmin_stat_frequency以上" do
        @words.each do |word|
          expect(word["stat_frequency"]).to be >= @min_stat_frequency
        end
      end
    end

  end
  
  before do
    @limit = 5001
    get v1_words_path, params: { limit: @limit, min_stat_frequency: @min_stat_frequency }
  end

  describe "5000より大きいlimitを指定した場合" do
    it "400返ってくる" do
      expect(response).to have_http_status(400)
    end

    it "エラーメッセージが返ってくる" do
      expect(JSON.parse(response.body)["error"]).to eq("limitは5000以下にしてください")
    end
  end
end
