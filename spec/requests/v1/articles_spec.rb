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

    it "Articleが存在しない場合は404を返す" do
      get "/v1/articles/-1"
      expect(response).to have_http_status(404)  
    end
  end

  describe "POST /create" do
    before do
      @params = { article: { title: "title", body: "body" } }
      post "/v1/articles/", params: @params
      @json = JSON.parse(response.body)
    end

    it "returns http success" do
      expect(response).to have_http_status(:created)
    end

    it "レスポンス形式が正しい" do
      keys = %w[id title body wordCount].sort
      expect(@json.keys.sort).to eq(keys)
    end

    it "Articleが作成される" do
      article = Article.find_by_id(@json["id"])
      expect(article).to be_present
    end
  end
end
