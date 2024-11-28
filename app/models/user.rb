class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable 
  has_many :bugs
  enum user_type: { manager: 0, developer: 1, qa: 2 }
  devise :database_authenticatable, :registerable, :validatable

         validates :name, presence: true
         validates :user_type, presence: true
  def admin?
    user_type == "manager"
  end

end
