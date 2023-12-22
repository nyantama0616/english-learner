require 'rails_helper'

RSpec.describe "V1::Weblios", type: :request do
  describe "GET /index" do
    before do
      get "/v1/weblio/apple"
    end

    it "200が返ってくる" do
      expect(response).to have_http_status(200)
    end

    it "html形式で返ってくる" do
      mime = "text/html; charset=utf-8"
      expect(response.content_type).to eq(mime)
    end
  end
end
