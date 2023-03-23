class SessionController < ApplicationController
  def index
    article = Article.find(params[:id])
    render json: article.slice(:id, :title, :minutes_to_read, :author, :content)
  end
end

class ArticlesController < ApplicationController
  before_action :check_page_views, only: :show

  def show
    @article = Article.find(params[:id])
    render json: @article.slice(:id, :title, :minutes_to_read, :author, :content)
  end

  private

  def check_page_views
    session[:page_views] ||= 0
    session[:page_views] += 1

    if session[:page_views] >= 3
      render json: { error: "Maximum pageview limit reached" }, status: :unauthorized
    end
  end
end


  