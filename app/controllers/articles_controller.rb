class ArticlesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    articles = if params[:title]
                 Article.where("title LIKE '%#{params[:title]}%'")
               else
                 Article.all
               end

    render json: articles
  end

  # POST /articles
  def create
    new_article = Article.create({ title: params[:title] })

    render json: new_article
  end

  # GET /articles/:id
  def show
    render json: {
      id: article.id,
      title: article.title,
      description: "#{article.id} - #{article.created_at} - title: \"#{article.title}\""
    }
  end

  # PUT /articles/:id
  def update
    article.title = params[:title] if params[:title]
    article.body = params[:body] if params[:body]

    article.save

    render json: article
  end

  # DELETE /articles/:id
  def destroy
    article.destroy

    head :ok # HTTP STATUS 200
  end

  private

  def article
    # ||= => memoization: affect result only if it does not exist
    @article ||= Article.find(params[:id])
  end
end
