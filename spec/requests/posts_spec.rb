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
  
  describe "GET /new" do
    context "when unauthenticated user" do
      it "returns http found" do
        get "/posts/new"
        expect(response).to have_http_status(:found)
      end
    end

    context "when authenticated user" do
      let(:user) { create(:user) }

      before { sign_in(user) }
      
      it "returns http success" do
        get "/posts/new"
        expect(response).to have_http_status(:success)
      end
    end
  end
end
