class ForumPostsController < ApplicationController
	def create
		@thread = ForumThread.find(params[:forum_thread_id])
		@post = ForumPost.new(call)

		@post.forum_thread = @thread
		@post.user = User.first

		@post.save
		redirect_to forum_thread_path
	end

	private

	def call
		params.require(:forum_post).permit(:content)
	end
end