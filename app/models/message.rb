class Message < ApplicationRecord
  validates :email, :message, presence: true
end
