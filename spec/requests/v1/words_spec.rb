require 'rails_helper'

RSpec.describe "V1::Words", type: :request do
  describe "GET /index" do
    before do
      get v1_words_path
      @words = JSON.parse(response.body)["words"] 
    end

    it "200返ってくる" do
      expect(response).to have_http_status(200)
    end

    it "単語が100個返ってくる" do
      expect(@words.length).to eq(100)
    end

    it "レスポンス形式が正しい" do
      expected = ["id", "word", "meaning"].sort
      expect(@words[0].keys.sort).to eq(expected)
    end
  end
end
