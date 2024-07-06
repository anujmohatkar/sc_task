class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :tasks, dependent: :destroy
  validates :email, 'valid_email_2/email': {mx: true, disposable: true, disallow_subaddressing: true, dns_timeout: 30}
end
