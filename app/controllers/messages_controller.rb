class MessagesController < ApplicationController
  before_action :set_message, only: %i[show update]
  before_action :set_messages, only: %i[index create search]
  skip_before_action :verify_authenticity_token

  # GET /applications/token/chats/number/messages
  def index
    render json: @messages.to_json(except: %i[id chat_id])
  end

  # GET /applications/token/chats/number/messages/number
  def show
    render json: @message.to_json(except: %i[id chat_id])
  end

  # POST /applications/token/chats/number/messages
  def create
    message_number = @messages.order(:number).last&.number || 0
    CreateMessageJob.perform_later(params[:application_token], params[:chat_number], message_params)

    render json: (message_number + 1)
  end

  # PATCH/PUT /applications/token/chats/number/messages/number
  def update
    if @message.update(message_params)
      render json: @message.to_json(except: %i[id chat_id])
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  # GET /applications/token/chats/number/search
  def search
    @messages = @messages.search(params[:q])

    if @messages.present?
      render json: @messages.to_json(except: %i[id chat_id])
    else
      render json: 'No resluts found', status: :unprocessable_entity
    end
  end

  private

  def set_messages
    application = Application.find_by(token: params[:application_token])
    @messages = application.chats.find_by(number: params[:chat_number]).messages
  end

  def set_message
    application = Application.find_by(token: params[:application_token])
    chat = application.chats.find_by(number: params[:chat_number])
    @message = chat.messages.find_by(number: params[:number])
  end

  def message_params
    params.require(:message).permit(:body)
  end
end
