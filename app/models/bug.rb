class Bug < ApplicationRecord
  belongs_to :created_by, class_name: 'User'
  belongs_to :assignee, class_name: 'User'
  belongs_to :project

  # Enum for bug_type 
  enum bug_type: { feature: 0, bug: 1 }

  # Enum for bug_status
  #I have replaced the new with open because rails is not allowing to use new as "new" is a class method which is already defined by Active Record. 
  enum bug_status: { open: 0, started: 1, completed: 2, resolved: 3 }

  # Validate presence of required fields
  validates :title, presence: true
  validates :bug_type, presence: true
  validates :bug_status, presence: true
  validates :project_id, presence: true
  validates :assignee_id, presence: true
  validates :created_by_id, presence: true

  # title is unique within a project
  validates :title, uniqueness: { scope: :project_id, message: "Title must be unique within the project" }

  # validation to ensure the correct bug_status based on bug_type
  validate :bug_status_is_valid_for_bug_type

  private

  # validation for bug_status based on bug_type
  def bug_status_is_valid_for_bug_type
    if bug_type == 'feature' && !["open", "started", "completed"].include?(bug_status)
      errors.add(:bug_status, 'must be open, started, or completed for a feature')
    elsif bug_type == 'bug' && !["open", "started", "resolved"].include?(bug_status)
      errors.add(:bug_status, 'must be open, started, or resolved for a bug')
    end
  end
end
