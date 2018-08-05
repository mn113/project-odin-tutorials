class ArticlesController < ApplicationController

    def index   # shows the list of all articles
        @articles = Article.all
    end

    def show
        @article = Article.find(params[:id])
    end

end
