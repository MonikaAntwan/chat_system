class CreateChatJob < ApplicationJob
  queue_as :default

  def perform(application_token)
    Application.find_by(token: application_token).chats.create
  end
end
