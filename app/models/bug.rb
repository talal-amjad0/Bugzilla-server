class Bug < ApplicationRecord
  belongs_to :created_by, class_name: 'User'
  belongs_to :assignee, class_name: 'User'
  belongs_to :project

  enum type: { feature: 0, bug: 1 }
  enum status: { new: 0, started: 1, completed: 2, resolved: 3 }
end
