require 'rails_helper'

RSpec.describe 'Chats', type: :request do
  describe 'GET /applications/:token/chats' do
    before do
      @application = Application.create(name: 'app')
      FactoryBot.create_list(:chat, 10, application_id: @application.id)
    end

    it 'returns all chats of an application' do
      get "/applications/#{@application.token}/chats"
      expect(JSON.parse(response.body).size).to eq(10)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /applications/:token/chats' do
    before do
      @application = Application.create(name: 'app')
    end

    it 'create a new chat to an application' do
      post "/applications/#{@application.token}/chats"
      expect(JSON.parse(response.body)).to eq(1)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /applications/:token/chats/:number' do
    before do
      @application = Application.create(name: 'app')
      @chat = @application.chats.create
    end

    it 'show a chat of an application' do
      get "/applications/#{@application.token}/chats/#{@chat.number}"
      expect(JSON.parse(response.body)['number']).to eq(1)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PUT /applications/:token/chats/:number' do
    before do
      @application = Application.create(name: 'app')
      @chat = @application.chats.create
    end

    it 'update a chat of an application' do
      put "/applications/#{@application.token}/chats/#{@chat.number}", params: { chat: { name: "chat 1" } }
      expect(JSON.parse(response.body)['name']).to eq('chat 1')
      expect(response).to have_http_status(:success)
    end
  end
end
