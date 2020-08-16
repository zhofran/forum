class ForumThreadsController < ApplicationController
	def index
		@thread = ForumThread.order(id: :desc)
	end

	def show
		@thread = ForumThread.find(params[:id])
		@post = ForumPost.new
	end

	def new
		@thread = ForumThread.new
	end

	def create
		@thread = ForumThread.new(call)
		@thread.user = User.first

		if @thread.save
			redirect_to root_path
		else
			render 'new'
		end
	end

	private

	def call
		params.require("forum_thread").permit(:title, :content)
	end
end