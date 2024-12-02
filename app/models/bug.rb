class Bug < ApplicationRecord
  belongs_to :created_by, class_name: 'User'
  belongs_to :assignee, class_name: 'User'
  belongs_to :project

  enum bug_type: { feature: 0, bug: 1 }
  enum bug_status: { open: 0, started: 1, completed: 2, resolved: 3 }
end
