class User < ActiveRecord::Base
  validates :username, :email, presence: true, uniqueness: { case_sensitive: false }
end