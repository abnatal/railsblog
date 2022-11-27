class CommentsController < ApplicationController
    before_action :set_post

    def create
        comment = @post.comments.create(comment_params.to_h.merge!({ user_id: current_user.id }))
        CommentsMailer.submitted(comment).deliver_later
        redirect_to @post
    end

    private
    def set_post
        @post = Post.find(params[:post_id])
    end

    def comment_params
        params.require(:comment).permit(:content)
    end
end
