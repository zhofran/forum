class ForumPostsController < ApplicationController
	before_action :authenticate_user!, only: [:create]

	def index
	end

	def show
	end

	def new
	end

	def create
		@thread = ForumThread.friendly.find(params[:forum_thread_id])
		@post = ForumPost.new(call)

		@post.forum_thread = @thread
		@post.user = current_user

		if @post.save
			redirect_to forum_thread_path(@thread)
		else
			render 'forum_threads/show'
		end
	end

	def edit
	end

	def update
	end

	def destroy
	end

	private

	def call
		params.require(:forum_post).permit(:content)
	end
end