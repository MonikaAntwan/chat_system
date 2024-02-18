class CreateMessageJob < ApplicationJob
  queue_as :default

  def perform(application_token, chat_number, params)
    application = Application.find_by(token: application_token)
    application.chats.find_by(number: chat_number).messages.create(params)
  end
end
