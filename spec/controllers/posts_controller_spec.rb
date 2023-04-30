require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe 'GET #index' do
    let(:posts) { create_list(:post, 3) }

    before { get :index }

    it 'assigns a posts list to @posts' do
      expect(assigns(:posts)).to match_array(posts)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    let(:post) { create(:post) }

    before { get :show, params: { id: post } }

    it 'assigns the requested post to @post' do
      expect(assigns(:post)).to eq post
    end

    it 'renders index show' do
      expect(response).to render_template :show
    end
  end
end
