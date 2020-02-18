class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  before_save :default_values

  def default_values
    self.wins ||= 0
  end

  has_many :games
  has_many :pieces

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
