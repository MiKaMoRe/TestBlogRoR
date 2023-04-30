require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe 'GET #index' do
    let(:posts) { create_list(:post, 24) }

    context 'without page' do
      before { get :index }
      
      it 'does not assign every post to @posts' do
        expect(assigns(:posts)).not_to match_array(posts)
      end

      it 'renders index view' do
        expect(response).to render_template :index
      end
    end

    context 'with second page' do
      before { get :index, params: { page: 2 } }

      it 'assigns last 12 posts to @posts' do
        expect(assigns(:posts)).to match_array(Post.last(12))
      end
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
