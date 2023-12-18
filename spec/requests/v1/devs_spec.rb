require 'rails_helper'

RSpec.describe "V1::Devs", type: :request do
  describe "GET /ping" do
    before do
      get "/v1/devs/ping"
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "returns pong" do
      expect(response.body).to eq({ message: "pong" }.to_json)
    end
  end
end
