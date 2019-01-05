class PostsController < ApplicationController
	
	before_action :move_to_index, except: :index

	def index
		@posts = Post.all 
	end

	def new

	end

	def create
		Post.create(text: post_params[:text], user_id: current_user.id)
	end

	def destroy
		post = Post.find(params[:id])
      if post.user_id == current_user.id
        post.destroy
      end
	end

	def show
		@post = Post.find(params[:id])
	end

	def edit
		@post = Post.find(params[:id])
	end

	def update
		post = Post.find(params[:id])
		if post.user_id == current_user.id
			post.update(post_params)
		end
	end

	private
	def post_params
		params.permit(:text)
	end

	def move_to_index
		redirect_to action: :index unless user_signed_in?
	end
end
