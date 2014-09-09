class Task < ActiveRecord::Base

  belongs_to :project
  acts_as_list scope: :project

  validates :name, length: { in: 1..1024, allow_nil: false }

end
