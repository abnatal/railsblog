class CommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_post
    before_action :can_modify?, only: %i[destroy]

    def create
        comment = @post.comments.create(comment_params.to_h.merge!({ user_id: current_user.id }))
        CommentsMailer.submitted(comment).deliver_later
        redirect_to @post
    end

    def destroy
        comment = @post.comments.find(params[:id])
        comment.destroy

        respond_to do |format|
            format.html { redirect_to post_path(@post), notice: "Comment was successfully deleted." }
            format.json { head :no_content }
        end
    end

    private
    def set_post
        @post = Post.find(params[:post_id])
    end

    def comment_params
        params.require(:comment).permit(:content)
    end

    def can_modify?
        comment = @post.comments.find(params[:id])
        unless current_user == comment.user
            redirect_back fallback_location: root_path, alert: 'User cannot delete this comment.'
        end
    end
end
