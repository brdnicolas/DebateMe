require 'rails_helper'

RSpec.describe 'V1 Themes API', type: :request do
  # initialize test data
  let!(:themes) { create_list(:theme, 10) }
  let(:theme_id) { themes.first.id }


  # Test suite for GET /themes
  describe 'GET /themes' do
    # make HTTP get request before each example
    before { get '/themes' }

    it 'returns themes' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /themes/:id
  describe 'GET /themes/:id' do
    before { get "/themes/#{theme_id}" }

    context 'when the record exists' do
      it 'returns the theme' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(theme_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:theme_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Theme/)
      end
    end
  end

  # Test suite for POST /themes
  describe 'POST /themes' do
    # valid payload
    let(:valid_attributes) { { name: "Les gros poissons" } }

    context 'when the request is valid' do
      before { post '/themes', params: valid_attributes }

      it 'creates a theme' do
        expect(json['name']).to eq('Les gros poissons')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/themes', params: {  } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
            .to match(/can't be blank/)
      end
    end
  end

  # Test suite for PUT /themes/:id
  describe 'PUT /themes/:id' do
    let(:valid_attributes) { { name: 'blabla@gmail.com' } }

    context 'when the record exists' do
      before { put "/themes/#{theme_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /themes/:id
  describe 'DELETE /themes/:id' do
    before { delete "/themes/#{theme_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end