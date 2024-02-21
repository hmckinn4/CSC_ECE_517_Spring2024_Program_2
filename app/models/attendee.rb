class Attendee < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :event_tickets, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :events, through: :event_tickets

  # Validations ensure all fields are filled upon edit / new action taken by user.
  validates :email, uniqueness: true, presence: true
  validates :name, presence: true
  validates :phone_number, presence: true, length: { is: 10 }
  validates :address, presence: true
  validates :credit_card_info, presence: true, length: { is: 16 }
end
