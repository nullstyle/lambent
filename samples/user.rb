require 'lambent'

class User
  include Lambent::Entity

  attribute :email, String
  attribute :username, String
  attribute :password_hash, String

  has_many :posts
  has_many :comments

end