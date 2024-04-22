class CommentsController < ApplicationController
    before_action :set_post

    def new
        @comment = @post.comments.new
    end

    def create
        @post = Post.find(params[:post_id])
        @comment = @post.comments.new(comment_params)
        @comment.user = current_user
        if @comment.save
        redirect_to @post, notice: "Comment was successfully created"
        else
        redirect_to @post, alert: "Comment was not created"
        end
    end
    
    def destroy
        @comment = @post.comments.find(params[:id])
        @comment.destroy
        redirect_to @post, notice: "Comment was successfully deleted"
    end
    
    private
    
    def comment_params
        params.require(:comment).permit(:content)
    end
    
    def set_post
        @post = Post.find(params[:post_id])
    rescue ActiveRecord::RecordNotFound
        redirect_to root_path
    end
end