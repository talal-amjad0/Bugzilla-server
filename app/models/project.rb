class Project < ApplicationRecord
    belongs_to :manager, class_name: 'User'
    has_many :bugs

    has_many :project_users
    has_many :users, through: :project_users
end
