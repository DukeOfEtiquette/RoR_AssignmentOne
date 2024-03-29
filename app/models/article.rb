class Article < ActiveRecord::Base
  belongs_to :user
  has_many :article_categories
  has_many :categories, through: :article_categories
  
  validates :title, :description, :user_id, presence: true
  
  validates :title, length: { minimum: 3, maximum: 50 }
  validates :description, length: { minimum: 5, maximum: 300 }
end