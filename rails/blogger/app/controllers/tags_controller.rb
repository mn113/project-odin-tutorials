class TagsController < ApplicationController
    def show
        @tag = Tag.find(params[:id])
    end

    def index
        @tags = Tag.all
    end

    def destroy
        @tag = Tag.find(params[:id])

        # first, delete all the Taggings records which reference this Tag:
        Tagging.where(tag_id: @tag.id).each{ |t| t.destroy }

        # now we're safe to proceed:
        flash.notice = "Tag '#{@tag}' deleted!"
        @tag.destroy

        redirect_to action: "index"
    end
end
