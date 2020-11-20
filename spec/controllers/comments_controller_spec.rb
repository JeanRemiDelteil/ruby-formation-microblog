require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  include ResponseHelper

  let(:author) { Author.create!(name: 'John Doe') }
  let(:article) { Article.create!(title: 'random title', body: 'random body', author: author) }
  let(:comment) { Comment.create!(content: 'first comment', article: article) }

  describe '#index' do
    it 'returns all comments for an article' do
      comments = [
        Comment.create!(content: 'first comment', article: article),
        Comment.create!(content: 'second comment', article: article),
      ]

      get :index, params: { article_id: article.id }

      data = parsed_response

      expect(data.size).to eq(comments.size)
      expect(data.map { |comment| comment['content'] }).to match(comments.map(&:content))
    end
  end

  describe "#show" do
    it 'returns a specific article with given ID' do
      get :show, params: {
        article_id: article.id,
        id: comment.id,
      }

      data = parsed_response

      expect(data['content']).to eq(comment.content)
      expect(data['article_id']).to eq(comment.article_id)
    end
  end

  describe '#create' do
    it 'creates and return a comment' do
      comment_data = { 'article_id' => article.id, 'content' => 'Random content' }

      post :create, params: comment_data

      data = parsed_response

      expect(data.slice('article_id', 'content')).to eq(comment_data)
    end
  end

  describe "#update" do
    it 'updates and returns a comment' do
      new_comment_data = {
        'content' => 'new content',
        'article_id' => article.id,
      }

      put :update, params: { id: comment.id, **new_comment_data }

      data = parsed_response
      comment.reload

      expect(comment.content).to eq(new_comment_data['content'])
      expect(data['content']).to eq(new_comment_data['content'])
    end
  end

  describe '#destroy' do
    it 'destroy the specific comment' do
      delete :destroy, params: {
        article_id: article.id,
        id: comment.id
      }

      expect(response.status).to eq(200)
      expect(Comment.find_by(id: comment.id)).to be_nil
    end
  end

end
