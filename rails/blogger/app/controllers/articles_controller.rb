class ArticlesController < ApplicationController
    
    include ArticlesHelper

    def index   # shows the list of all articles
        @articles = Article.all
    end


    def show
        @article = Article.find(params[:id])
        @comment = Comment.new  # must be here for comment form
        @comment.article_id = @article.id
    end


    def new
        @article = Article.new # new instance must be there in order for the form to be rendered
    end

    def create  # accepts form submission
        @article = Article.new(article_params)    # contains :title & :body
        @article.save

        flash.notice = "Article '#{@article.title}' created!"

        redirect_to article_path(@article)
    end


    def edit
        @article = Article.find(params[:id]) # prepare the data for the  edit form
    end

    def update
        @article = Article.find(params[:id])
        @article.update(article_params)

        flash.notice = "Article '#{@article.title}' updated!"

        redirect_to article_path(@article)
    end


    def destroy
        @article = Article.find(params[:id])
        flash.notice = "Article '#{@article.title}' deleted!"
        @article.destroy

        redirect_to action: "index"
    end

end
