require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  describe 'POST #create' do
    let(:post_create) { post :create, params: { comment: comment_params, post_id: create(:post).id } }

    context 'when authenticated user' do
      let(:user) { create(:user) }
      
      before { sign_in user }

      context 'with valid params' do
        let(:comment_params) { attributes_for(:comment) }

        it 'creates a new comment' do
          expect { post_create }.to change(Comment, :count).by(1)
        end
      end

      context 'with invalid params' do
        let(:comment_params) { attributes_for(:comment, :invalid) }

        it 'does not create a new comment' do
          expect { post_create }.not_to change(Comment, :count)
        end
      end
    end
  end
end