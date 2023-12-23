require 'rails_helper'

RSpec.describe "V1::Articles", type: :request do
  describe "GET /index" do
    before do
      FactoryBot.create_list(:article, 3)
      get "/v1/articles/"
      @json = JSON.parse(response.body)
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "レスポンス形式が正しい" do
      keys = %w[id title wordCount].sort
      
      expect(@json["articles"][0].keys.sort).to eq(keys)
    end
  end

  describe "GET /show" do
    before do
      @article = FactoryBot.create(:article)
      get "/v1/articles/#{@article.id}"
      @json = JSON.parse(response.body)
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "レスポンス形式が正しい" do
      keys = %w[id title body wordCount].sort
      expect(@json.keys.sort).to eq(keys)
    end
  end
end
