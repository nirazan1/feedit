class CommentsController < ApplicationController

	# http_basic_authenticate_with name: "root", password: "passpass", only: :destroy

	def create
		@feed = Feed.find(params[:feed_id])
		@comment = @feed.comments.create(comment_params)
		@comment.commenter = current_user.username
		@comment.user_id = current_user.id

		respond_to do |format|
			if @comment.save
				format.html { redirect_to @feed, notice: 'Comment was successfully posted' }
				format.js
			end
		end
	end

	def destroy
		@feed = Feed.find(params[:feed_id])
		@comment = @feed.comments.find(params[:id])
		@comment.destroy
    respond_to do |format|
      format.html { redirect_to feed_path(@feed),notice: 'Feed was successfully deleted.' }
      format.js
    end

	end

	private

	def comment_params
		params.require(:comment).permit(:body)
	end

end


