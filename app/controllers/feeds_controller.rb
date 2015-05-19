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
		respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @feeds }
    end
	end

	def create
		@feed = current_user.feeds.build(feed_params)
		@feed.name = current_user.username
		respond_to do |format|
      if @feed.save
        format.html { redirect_to @feed, notice: 'Feed was successfully created.' }
        format.js
      else
        format.html { render action: "index" }
        format.js
      end
    end
	end

	def edit
		@feed = Feed.find(params[:id])
	end

	def update
		@feed = Feed.find(params[:id])
		respond_to do |format|
			if @feed.update(feed_params)
	      format.html { redirect_to feeds_path }
	      format.js
			else
				format.html { render :edit }
	      format.js
			end
		end
	end

	def show
		@feed = Feed.find(params[:id])
	end

	def destroy
		@feed = Feed.find(params[:id])
		@feed.destroy
		respond_to do |format|
      format.html { redirect_to feeds_url,notice: 'Feed was successfully deleted.' }
      format.js
    end
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
		params.require(:feed).permit(:name,:text)
	end

end
