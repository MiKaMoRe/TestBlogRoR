class Comment < ApplicationRecord
  belongs_to :author, foreign_key: 'author_id', class_name: 'User'
  belongs_to :post

  validates :body, presence: :true
end
