class Author < ApplicationRecord
  include TrashAble

  has_many :articles, dependent: :destroy
end
