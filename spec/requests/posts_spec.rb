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

  describe 'POST /create' do
    let(:post_create) { post '/posts', params: { post: post_params } }

    context 'when authenticated user' do
      let(:user) { create(:user) }

      before { sign_in(user) }

      context 'with valid params' do
        let(:post_params) { attributes_for(:post) }
        it 'returns http success' do
          post_create
          expect(response).to have_http_status(:found)
        end
      end

      context 'with invalid params' do
        let(:post_params) { attributes_for(:post, description: '') }
  
        it 'returns http unprocessable entity' do
          post_create
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    context 'when unauthenticated user' do
      let(:post_params) { attributes_for(:post) }

      it 'returns http found' do
        post_create
        expect(response).to have_http_status(:found)
      end
    end
  end

  describe 'DELETE /destroy' do
    let(:delete_destroy) { delete post_path(post)  }

    context 'when authenticated user' do
      let(:user) { create(:user) }

      before { sign_in(user) }

      context 'and it is a author of a post' do
        let!(:post) { create(:post, author: user) }

        it 'returns http found' do
          delete_destroy
          expect(response).to have_http_status(:found)
        end
      end

      context 'and it is not a author of a post' do
        let!(:post) { create(:post) }

        it 'returns http forbidden' do
          delete_destroy
          expect(response).to have_http_status(:forbidden)
        end
      end
    end

    context 'when unauthenticated user' do
      let!(:post) { create(:post) }

      it 'returns http found' do
        delete_destroy
        expect(response).to have_http_status(:found)
      end
    end
  end
end
