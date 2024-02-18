require 'rails_helper'

RSpec.describe 'Apllications', type: :request do
  describe 'GET /applications' do
    before do
      FactoryBot.create_list(:application, 10)
    end

    it 'returns all applications' do
      get '/applications'
      expect(JSON.parse(response.body).size).to eq(10)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /applications' do
    it 'create a new application' do
      post '/applications', params: { application: { name: 'app' } }
      expect(JSON.parse(response.body)['name']).to eq('app')
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /applications/:token' do
    before do
      @application = Application.create(name: 'app')
    end

    it 'show an application' do
      get "/applications/#{@application.token}"
      expect(JSON.parse(response.body)['name']).to eq('app')
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PUT /applications/:token' do
    before do
      @application = Application.create(name: 'app')
    end

    it 'update an application' do
      put "/applications/#{@application.token}", params: { application: { name: 'application' } }
      expect(JSON.parse(response.body)['name']).to eq('application')
      expect(response).to have_http_status(:success)
    end
  end
end
