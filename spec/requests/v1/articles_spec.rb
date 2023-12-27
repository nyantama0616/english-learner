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
      expect(response).to have_http_status(201)
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

  describe "PATCH /update" do
    before do
      @article = FactoryBot.create(:article)
      @params = { article: { title: "title", body: "body" } }
      patch "/v1/articles/#{@article["id"]}", params: @params
      @json = JSON.parse(response.body)
    end

    it "returns http success" do
      expect(response).to have_http_status(200)
    end

    it "レスポンス形式が正しい" do
      keys = %w[id title body wordCount].sort
      expect(@json.keys.sort).to eq(keys)
    end

    it "Articleが更新される" do
      article = Article.find_by_id(@article["id"])
      expect(article.title).to eq(@params[:article][:title])
      expect(article.body).to eq(@params[:article][:body])
    end

    it "Articleが存在しない場合は404を返す" do
      get "/v1/articles/-1", params: @params
      expect(response).to have_http_status(404)  
    end
  end

  describe "GET /articles/:article_id/word_dict" do
    before do
      title = "Test Article"
      body = <<~TEXT
        I was born ?Q?.
      TEXT
      
      @article = FactoryBot.create(:article, title: title, body: body)

      get "/v1/articles/#{@article["id"]}/word_dict"
      @json = JSON.parse(response.body)
    end

    it "200が返ってくる" do
      expect(response).to have_http_status(200)
    end
    
    it "レスポンス形式が正しい" do
      expect(@json["words"]["i"]).to eq(Word.find_by_name("i").info)
    end
    
    it "存在しない単語はレスポンスに含まない" do
      expect(@json["words"]["?Q?"]).to eq(nil)
    end

    it "Articleが存在しない場合は404を返す" do
      get "/v1/articles/-1/word_dict"
      expect(response).to have_http_status(404)
    end
  end

  describe "GET /articles/:article_id/words" do
    before do
      title = "Test Article"
      body = <<~TEXT
        I am 20.
        I was born in America.
      TEXT
      
      @article = FactoryBot.create(:article, title: title, body: body)

      get "/v1/articles/#{@article["id"]}/words"
      @json = JSON.parse(response.body)
    end

    it "200が返ってくる" do
      expect(response).to have_http_status(200)
    end

    it "レスポンス形式が正しい" do
      word_json = @json["words"][0]
      word = Word.find_by_name(word_json["word"])
      expect(word_json).to eq(word.info)
    end

    it "単語の基本形のリストが返ってくる" do
      expected = %w[test article i be bear in america]
      words = @json["words"].map { |word| word["word"] }
      
      expect(words.sort).to eq(expected.sort)
    end
  end
end
