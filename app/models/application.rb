class Application < ApplicationRecord
  has_many :chats

  before_create :set_token

  private

  def set_token
    self.token = generate_token
  end

  def generate_token
    loop do
      token = SecureRandom.hex(10)
      break token unless Application.where(token: token).exists?
    end
  end
end
