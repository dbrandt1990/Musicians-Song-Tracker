class User < ActiveRecord::Base
    validates :email, presence: true
    validates :username, presence: true
    validates :password, presence: true
    validates_uniqueness_of :email
    validates_uniqueness_of :username
    has_secure_password
    has_many :songs
end