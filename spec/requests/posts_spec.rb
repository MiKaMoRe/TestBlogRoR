require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/posts"
      expect(response).to have_http_status(:success)
    end

    context "root url" do
      it "returns http success" do
        get "/"
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "GET /show" do
    let(:post) { create(:post) }

    it "returns http success" do
      get "/posts", params: { id: post.id }
      expect(response).to have_http_status(:success)
    end
  end

end
