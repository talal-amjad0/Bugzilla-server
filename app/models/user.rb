class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable 
  has_many :project_users
  has_many :projects, through: :project_users
  
  has_many :bugs
  enum user_type: { manager: 0, developer: 1, qa: 2 }
  devise :database_authenticatable, :registerable, :validatable

         validates :name, presence: true
         validates :user_type, presence: true
  def manager?
    user_type == "manager"
  end

  def developer?
    user_type == "developer"
  end

  def qa?
    user_type == "qa"
  end

end
