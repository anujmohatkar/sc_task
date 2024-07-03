class Task < ApplicationRecord
  belongs_to :user

  enum status: {pending: 0, in_progress: 1, completed: 2}
  validates :name, presence: true, length: {minimum:5}
  validates :due_date, presence: true
end
