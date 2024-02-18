class Message < ApplicationRecord
  include Searchable
  belongs_to :chat, counter_cache: true

  auto_increment :number, scope: :chat_id
end
