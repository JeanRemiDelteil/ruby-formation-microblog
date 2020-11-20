require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  include ResponseHelper

  let(:author) { Author.create!(name: 'John Doe') }

  describe "#index" do
    it 'returns all articles' do
      articles = [
        Article.create!(title: 'first title', body: 'random body', author: author),
        Article.create!(title: 'second title', body: 'random body', author: author)
      ]

      get :index

      body = parsed_response
      expect(body.size).to eq(articles.size)

      # match doesn't care about array order
      expect(body.map { |item| item['title']}).to match(articles.map(&:title))
    end
  end

  describe '#create' do
    it 'creates and return an article' do
      article_data = {
        'title' => 'random title',
        'body' => 'random body',
        'author_id' => author.id,
      }

      post :create, params: article_data

      body = parsed_response

      expect(body['id']).not_to eq(nil)
      # expect(body['title']).to eq(article_data[:title])
      # expect(body['body']).to eq(article_data[:body])
      # expect(body['author_id']).to eq(article_data[:author_id])

      expect(body.slice('title', 'body', 'author_id')).to eq(article_data)
    end
  end

  describe "#show" do
    it 'returns the article with given ID' do
      article = Article.create!(
        title: 'first article',
        body: 'a body',
        author: author,
      )

      get :show, params: { id: article.id }

      body = parsed_response
      keys = %w[id title body author_id]

      expect(body.slice(*keys)).to eq(article.attributes.slice(*keys))
    end
  end

  describe '#update' do
    it 'returns and updates the article with given ID' do
      article = Article.create!(
        title: 'first article',
        body: 'a body',
        author: author,
      )

      update_data = {
        title: 'new title',
        body: 'new body',
      }

      put :update, params: { id: article.id, **update_data }

      # Update the record from the DB
      article.reload

      body = parsed_response
      keys = %w[title body]

      expect(body['id']).to eq(article.id)
      expect(body.slice(*keys)).to eq(article.attributes.slice(*keys))
    end
  end

  # TODO: test #destroy
end
