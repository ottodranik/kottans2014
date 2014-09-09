class Project < ActiveRecord::Base

  belongs_to :user
  has_many :tasks, -> { order("position ASC, updated_at DESC") }, dependent: :destroy
  acts_as_list

  default_scope { order("position ASC, updated_at DESC") }

  validates :name, length: { in: 1..1024, allow_nil: false }

end
