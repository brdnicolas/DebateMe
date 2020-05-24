require 'rails_helper'

RSpec.describe 'V1 Questions API' do
  # Initialize the test data
  let!(:theme) { create(:theme) }
  let(:theme_id) { theme.id }
  let!(:questions) { create_list(:question, 20, theme_id:  theme.id) }
  let(:id) {questions.first.id}

  # Test suite for GET /themes/:theme_id/questions
  describe 'GET /themes/:theme_id/questions' do
    before { get "/themes/#{theme_id}/questions" }

    context 'when theme exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all theme questions' do
        expect(json.size).to eq(20)
      end
    end

    context 'when theme does not exist' do
      let(:theme_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Theme/)
      end
    end
  end

  # Test suite for GET /themes/:theme_id/questions/:id
  describe 'GET /themes/:theme_id/questions/:id' do
    before { get "/themes/#{theme_id}/questions/#{id}" }

    context 'when theme question exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the question' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when theme question does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Question/)
      end
    end
  end

  # Test suite for POST /themes/:theme_id/questions
  describe 'POST /themes/:theme_id/questions' do
    let(:valid_attributes) { { title: 'Black Puppet', documentation: "PaPiProut", start_time: "2020-05-23 16:15:40", end_time: "2020-05-23 17:15:40" } }

    context 'when request attributes are valid' do
      before { post "/themes/#{theme_id}/questions", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/themes/#{theme_id}/questions", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/can't be blank/)
      end
    end
  end

  describe 'PUT /themes/:theme_id/questions/:id' do
    let(:valid_attributes) { { title: 'Purple Puppet' } }

    before { put "/themes/#{theme_id}/questions/#{id}", params: valid_attributes }

    context 'when question exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the question' do
        updated_post = Question.find(id)
        expect(updated_post.title).to match(/Purple Puppet/)
      end
    end

    context 'when the question does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Question/)
      end
    end
  end

  # Test suite for DELETE /themes/:theme_id/questions/:id
  describe 'DELETE /themes/:theme_id/questions/:id' do
    before { delete "/themes/#{theme_id}/questions/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end