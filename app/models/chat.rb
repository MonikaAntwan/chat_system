class Chat < ApplicationRecord
  belongs_to :application, counter_cache: true
  has_many :messages

  auto_increment :number, scope: :application_id
end
