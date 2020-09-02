class ForumThreadsController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create]

	def index
		if params[:search]
			@threads = ForumThread.where('title ilike ?', "%#{params[:search]}%").paginate(per_page: 5, page: params[:page])
		else
			@threads = ForumThread.order(sticky_order: :asc).order(id: :desc).paginate(per_page: 5, page: params[:page])
		end
	end

	def show
		@thread = ForumThread.friendly.find(params[:id])
		@post = ForumPost.new
		@posts = @thread.forum_post.paginate(per_page: 5, page: params[:page])
	end

	def new
		@thread = ForumThread.new
	end

	def create
		@thread = ForumThread.new(call)
		@thread.user = current_user

		if @thread.save
			redirect_to root_path
		else
			render 'new'
		end
	end

	def edit
		@thread = ForumThread.friendly.find(params[:id])
		authorize @thread
	end

	def update
		@thread = ForumThread.friendly.find(params[:id])
		authorize @thread

		if @thread.update(call)
			redirect_to forum_thread_path(@thread)
		else
			render 'edit'
		end
	end

	def destroy
		@thread = ForumThread.friendly.find(params[:id])
		authorize @thread
		@thread.destroy

		redirect_to root_path, notice: 'Thread telah dihapus'
	end

	def pinkuy
		@thread = ForumThread.friendly.find(params[:id])
		@thread.pins
		redirect_to root_path
	end

	private

	def call
		params.require("forum_thread").permit(:title, :content)
	end
end