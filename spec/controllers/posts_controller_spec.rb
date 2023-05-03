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

      it 'returns http success' do
        expect(response).to have_http_status(:success)
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

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #new' do
    context "when authenticated user" do
      before do
        sign_in(create(:user))
        get :new
      end

      it 'assigns a new Post to @post' do
        expect(assigns(:post)).to be_a_new(Post)
      end

      it 'renders new view' do
        expect(response).to render_template :new
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end
    end

    context "when unauthenticated user" do
      before { get :new }

      it 'redirects to sign in' do
        expect(response).to redirect_to new_user_session_path
      end

      it 'returns http found' do
        expect(response).to have_http_status(:found)
      end
    end
  end

  describe 'POST #create' do
    let(:user) { create(:user) }
    let(:post_create) { post :create, params: { post: post_params } }

    context 'when authenticated user' do
      before { sign_in(user) }

      context 'with valid params' do
        let(:post_params) { attributes_for(:post) }

        it 'saves a new post in database' do
          expect { post_create }.to change(Post, :count).by(1)
        end

        it 'redirect to show view' do
          post_create
          expect(response).to redirect_to assigns(:post)
        end

        it 'returns http success' do
          post_create
          expect(response).to have_http_status(:found)
        end
      end

      context 'with invalid params' do
        let(:post_params) { attributes_for(:post, title: '') }

        it 'does not save the question' do
          expect { post_create }.not_to change(Post, :count)
        end

        it 'returns http unprocessable entity' do
          post_create
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    context 'when unauthenticated user' do
      let(:post_params) { attributes_for(:post) }

      before { post_create }

      it 'redirect to sign in' do
        expect(response).to redirect_to new_user_session_path
      end

      it 'returns http found' do
        expect(response).to have_http_status(:found)
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:delete_destroy) { delete :destroy, params: { id: post } }

    context 'when authenticated user' do
      let(:user) { create(:user) }

      before { sign_in(user) }

      context 'and it is a author of a post' do
        let!(:post) { create(:post, author: user) }

        it 'deletes the answer' do
          expect { delete_destroy }.to change(Post, :count).by(-1)
        end

        it 'redirect to post index' do
          delete_destroy
          expect(response).to redirect_to posts_path
        end

        it 'returns http found' do
          delete_destroy
          expect(response).to have_http_status(:found)
        end
      end

      context 'and it is not a author of a post' do
        let!(:post) { create(:post) }

        it 'not deletes the answer' do
          expect { delete_destroy }.not_to change(Post, :count)
        end

        it 'returns http forbidden' do
          delete_destroy
          expect(response).to have_http_status(:forbidden)
        end
      end
    end

    context 'when unauthenticated user' do
      let!(:post) { create(:post) }

      it 'not deletes the answer' do
        expect { delete_destroy }.not_to change(Post, :count)
      end

      it 'redirect to sign in' do
        delete_destroy
        expect(response).to redirect_to new_user_session_path
      end

      it 'returns http found' do
        delete_destroy
        expect(response).to have_http_status(:found)
      end
    end
  end
end
