class Message < ApplicationRecord
  belongs_to :group
  belongs_to :user

  validates :content, presence: true, unless: :image?

  mount_uploader :image, ImageUploader  # Carrierwave導入時に追記
end
