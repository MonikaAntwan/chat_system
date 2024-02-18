require 'rails_helper'

RSpec.describe 'Messages', type: :request do
  describe 'GET /applications/:token/chats/:chat_number/messages' do
    before do
      @application = Application.create(name: 'app')
      @chat = @application.chats.create
      FactoryBot.create_list(:message, 10, chat_id: @chat.id)
    end

    it 'returns all messages of a chat' do
      get "/applications/#{@application.token}/chats/#{@chat.number}/messages"
      expect(JSON.parse(response.body).size).to eq(10)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /applications/:token/chats/:chat_number/messages' do
    before do
      @application = Application.create(name: 'app')
      @chat = @application.chats.create
    end

    it 'create a new message to a chat' do
      post "/applications/#{@application.token}/chats/#{@chat.number}/messages", params: { message: { body: 'Hi' } }
      expect(JSON.parse(response.body)).to eq(1)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /applications/:token/chats/:chat_number/messages/:number' do
    before do
      @application = Application.create(name: 'app')
      @chat = @application.chats.create
      @message = @chat.messages.create(body: 'Hi')
    end

    it 'show a message of a chat' do
      get "/applications/#{@application.token}/chats/#{@chat.number}/messages/#{@message.number}"
      expect(JSON.parse(response.body)['body']).to eq('Hi')
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PUT /applications/:token/chats/:chat_number/messages/:number' do
    before do
      @application = Application.create(name: 'app')
      @chat = @application.chats.create
      @message = @chat.messages.create(body: 'Hi')
    end

    it 'update a chat of an application' do
      put "/applications/#{@application.token}/chats/#{@chat.number}/messages/#{@message.number}",
          params: { message: { body: 'How are you ?' } }
      expect(JSON.parse(response.body)['body']).to eq('How are you ?')
      expect(response).to have_http_status(:success)
    end
  end
end
