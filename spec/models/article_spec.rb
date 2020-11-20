require 'rails_helper'

RSpec.describe Article, type: :model do

  let(:author) { Author.create!(name: 'John Doe') }

  describe "Validations" do
    it "does not allow blank title" do
      # article = Article.create(body: 'random body', author: author)
      #
      # expect( article.persisted? ).to eq(false)
      # expect( article.errors.details[:title] ).to eq([{error: :blank}])

      # Another method is to check if it raises an error
      expect do
        Article.create!(body: 'random body', author: author)
      end.to raise_error(ActiveRecord::RecordInvalid, /title can't be blank/i)

    end

    it "does not allow blank body" do
      article = Article.create(title: "Random title", author: author)

      expect( article.persisted? ).to eq(false)
      expect( article.errors.details[:body] ).to eq([{error: :blank}])
    end
  end

  describe "Deletion" do
    let(:article) { Article.create!(title: 'random title', body: 'random body', author: author) }

    before(:each) do
      article.destroy
    end

    it "sets is_trashed to true" do
      expect(article.is_trashed).to eq(true)
    end

    it "does not delete article from DB" do
      expect(Article.unscoped.find_by(id: article.id)).not_to eq(nil)
    end
  end

  describe "With Status Scope" do
    # let(:article) { Article.create!(title: 'random title', body: 'random body', author: author) }

    it 'does not return articles without status' do
      Article.create!(title: 'random title', body: 'random body', author: author, status: nil)
      Article.create!(title: 'random title', body: 'random body', author: author, status: :draft)

      articles = Article.with_status

      expect(articles.find { |article| article.status.nil? }).to eq(nil)
    end
  end
end
