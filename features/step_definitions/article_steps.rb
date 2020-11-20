Given(/^I query the index actions$/) do
  author = Author.create!(name: 'John Doe')
  @article = Article.create!(title: 'new article', body: 'random body', author: author)

  visit '/articles'
end

Then(/^I should see all articles$/) do
  article_data = JSON.parse(page.body)[0]

  expect(article_data['title']).to eq(@article.title)
end

Given(/^I query the create actions$/) do
  author = Author.create!(name: 'John Doe')
  @article_data = {
    title: 'new article',
    body: 'random body',
    author_id: author.id,
  }

  page.driver.post('/articles', @article_data)
end

Then(/^I should get a new article created in the Database$/) do
  response = JSON.parse(page.body)

  expect(response['id']).not_to be_nil
  # ...
end
