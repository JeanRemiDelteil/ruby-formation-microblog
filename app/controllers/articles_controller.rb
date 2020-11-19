class ArticlesController < ApplicationController
  def index
  end

  def create
  end

  def show
    render plain: params.inspect
  end
end
