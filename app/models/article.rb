class Article < ApplicationRecord
  include TrashAble

  validates :title, presence: true
  validates :body, presence: true

  belongs_to :author
  has_many :comments

  enum status: %i(draft published)

  scope :with_title, -> { where.not(title: nil) }
  scope :with_author, -> { where.not(author_id: nil) }
  scope :with_status, -> { where.not(status: nil) }
end
