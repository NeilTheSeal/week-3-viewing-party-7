class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true, uniqueness: true
  validates_presence_of :password_digest
  has_many :viewing_parties

  has_secure_password
end
