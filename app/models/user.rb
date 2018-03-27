class User < ActiveRecord::Base
  has_many :articles
  
  before_save { self.email = email.downcase }
  
  validates :username, :email, presence: true, uniqueness: { case_sensitive: false }
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, length: { maximum: 105 }, format: { with: VALID_EMAIL_REGEX }
  validates :username, length: { minimum: 3, maximum: 25 }
end