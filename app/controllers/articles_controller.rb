class ArticlesController < ApplicationController
  before_action :check_page_views, only: [:show, :index]

  def index
    @articles = Article.order(id: :desc)
    render json: @articles.map { |article|
    {
      id: article.id,
      title: article.title,
      minutes_to_read: article.minutes_to_read,
      author: article.author,
      preview: "paragraph 1"
  }
    }
  end
  
  def show
    @article = Article.find(params[:id])
    render json: @article.as_json.merge(
      content: @article.content,
      minutes_to_read: @article.minutes_to_read,
      author: @article.author,
      title: @article.title,
      id: @article.id
    )
  end

  private

  def check_page_views
    session[:page_views] ||= 0
    session[:page_views] += 1

    if session[:page_views] > 3
      render json: { error: "Maximum pageview limit reached" }, status: :unauthorized
    end
  end
end



