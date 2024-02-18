class ChatsController < ApplicationController
  before_action :set_chat, only: %i[show update]
  before_action :set_chats, only: %i[index create]
  skip_before_action :verify_authenticity_token

  # GET /applications/token/chats
  def index
    render json: @chats.to_json(except: %i[id application_id])
  end

  # GET /applications/token/chats/number
  def show
    render json: @chat.to_json(except: %i[id application_id])
  end

  # POST /applications/token/chats
  def create
    chat_number = @chats.order(:number).last&.number || 0
    CreateChatJob.perform_later(params[:application_token])

    render json: (chat_number + 1)
  end

  # PATCH/PUT /applications/token/chats/number
  def update
    if @chat.update(chat_params)
      render json: @chat.to_json(except: %i[id application_id])
    else
      render json: @chat.errors, status: :unprocessable_entity
    end
  end

  private

  def set_chats
    @chats = Application.find_by(token: params[:application_token]).chats
  end

  def set_chat
    application = Application.find_by(token: params[:application_token])
    @chat = application.chats.find_by(number: params[:number])
  end

  def chat_params
    params.require(:chat).permit(:name)
  end
end
