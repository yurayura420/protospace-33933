class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :profile, presence: true
  validates :occupation, presence: true
  validates :position, presence: true   
  validates :name, presence: true   
  has_many :prototypes
  has_many :comments
end