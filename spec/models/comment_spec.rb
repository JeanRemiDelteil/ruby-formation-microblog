require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:author) { Author.create!(name: 'John Doe') }
  let(:article) { Article.create!(title: 'random title', body: 'random body', author: author) }

  describe 'Validations' do
    it 'does not allow blank content' do
      expect do
        Comment.create!(article: article)
      end.to raise_error(ActiveRecord::RecordInvalid, /content can't be blank/i)
    end
  end

end
