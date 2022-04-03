class Article < ApplicationRecord
  validates :title, presence: true, length: { minimum: 3 }
  validates :body, presence: true, length: { minimum: 5 }
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_one_attached :article_image
end
