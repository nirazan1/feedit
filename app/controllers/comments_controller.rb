class CommentsController < ApplicationController

	# http_basic_authenticate_with name: "root", password: "passpass", only: :destroy

	def create
		@feed = Feed.find(params[:feed_id])
		@comment = @feed.comments.create(comment_params)
		@comment.commenter = current_user.username
		@comment.user_id = current_user.id
		

		if @comment.save
			flash[:notice] = "#{@comment.commenter}'s comment created !!"
			redirect_to feed_path(@feed)
		end
	end

	def destroy
		@feed = Feed.find(params[:feed_id])
		@comment = @feed.comments.find(params[:id])
		@comment.destroy 
		flash[:notice] = "#{@comment.commenter}'s comment deleted !!"
		redirect_to feed_path(@feed)

	end

	private

	def comment_params
		params.require(:comment).permit(:body)
	end

end


