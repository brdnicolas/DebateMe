require 'rails_helper'

RSpec.describe 'V1 Posts API' do
  # Initialize the test data
  let!(:user) { create(:user) }
  let(:user_id) { user.id }
  let!(:posts) { create_list(:post, 20, user_id:  user.id) }
  let(:id) { posts.first.id }

  # Test suite for GET /users/:user_id/posts
  describe 'GET /users/:user_id/posts' do
    before { get "/users/#{user_id}/posts" }

    context 'when user exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all user posts' do
        expect(json.size).to eq(20)
      end
    end

    context 'when user does not exist' do
      let(:user_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find User/)
      end
    end
  end

  # Test suite for GET /users/:user_id/posts/:id
  describe 'GET /users/:user_id/posts/:id' do
    before { get "/users/#{user_id}/posts/#{id}" }

    context 'when user post exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the post' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when user post does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Post/)
      end
    end
  end

  # Test suite for POST /users/:user_id/posts
  describe 'POST /users/:user_id/posts' do
    let(:valid_attributes) { { content: 'Black Puppet', isAnonym: false, up: 50, down: 4, user_id: 136 } }

    context 'when request attributes are valid' do
      before { post "/users/#{user_id}/posts", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/users/#{user_id}/posts", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/can't be blank/)
      end
    end
  end

  # Test suite for PUT /users/:user_id/posts/:id
  describe 'PUT /users/:user_id/posts/:id' do
    let(:valid_attributes) { { content: 'Purple Puppet' } }

    before { put "/users/#{user_id}/posts/#{id}", params: valid_attributes }

    context 'when post exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the post' do
        updated_post = Post.find(id)
        expect(updated_post.content).to match(/Purple Puppet/)
      end
    end

    context 'when the post does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Post/)
      end
    end
  end

  # Test suite for DELETE /users/:user_id/posts/:id
  describe 'DELETE /users/:user_id/posts/:id' do
    before { delete "/users/#{user_id}/posts/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end