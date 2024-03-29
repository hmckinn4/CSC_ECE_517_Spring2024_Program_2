class Attendee < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :event_tickets, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :events, through: :event_tickets
  validates :email, uniqueness: true, presence: true
end
