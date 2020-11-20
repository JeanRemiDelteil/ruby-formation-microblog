class Article < ApplicationRecord
  include TrashAble

  validates :title, presence: true

  belongs_to :author

  scope :with_title, -> { where.not(title: nil) }
  scope :with_author, -> { where.not(author_id: nil) }
end
