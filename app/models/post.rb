class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_one_attached :image

  belongs_to :author, foreign_key: 'author_id', class_name: 'User'

  validates :title, :description, presence: :true
end
