class FeedsController < ApplicationController
	# http_basic_authenticate_with name: "root", password: "passpass", except: [:index, :show]
	# before_action :authenticate_user! , except: [:index, :show]
	load_and_authorize_resource except: [:create] 

	def new
		@feed = current_user.feeds.build
	end

	def index
		@feeds = Feed.all
		@feed = Feed.new
	end

	def create
		@feed = current_user.feeds.build(feed_params)
		# @feed.name = current_user.first_name

		if @feed.save
			flash[:notice] = " New feed created !"
			redirect_to feeds_path
		else
			render 'new'
		end
	end

	def edit
		@feed = Feed.find(params[:id])
	end

	def update
		@feed = Feed.find(params[:id])

		if @feed.update(feed_params)
			flash[:notice] = " Feed updated !"
			redirect_to feeds_path
		else
			render 'edit'
		end
	end

	def show
		@feed = Feed.find(params[:id])
	end

	def destroy
		@feed = Feed.find(params[:id])
		flash[:alert] = " Feed deleted !"
		@feed.destroy

		redirect_to feeds_path
	end

	def upvote
		@feed = Feed.find(params[:id])
		@feed.upvote_by current_user
		redirect_to (:back)
	end

	def unvote
		@feed = Feed.find(params[:id])
		@feed.unvote_by current_user
		redirect_to (:back)
	end

	def downvote
		@feed = Feed.find(params[:id])
		@feed.downvote_by current_user
		redirect_to (:back)
	end

	
	private
	def feed_params
		params.require(:feed).permit(:text)
	end

end
