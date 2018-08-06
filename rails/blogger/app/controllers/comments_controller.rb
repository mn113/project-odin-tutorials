class CommentsController < ApplicationController

    include CommentsHelper

    def create  # accepts form submission
        @comment = Comment.new(comment_params)    # contains :author_name & :body
        @comment.article_id = params[:article_id]
        @comment.save

        flash.notice = "Comment added!"

        redirect_to article_path(@comment.article)
    end

end
