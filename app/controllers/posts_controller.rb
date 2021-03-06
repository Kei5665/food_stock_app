class PostsController < ApplicationController
  
  before_action :authenticate_user
  
  def index
   @posts = Post.all.order(created_at: :desc)
  end
  
  def show
    @post = Post.find_by(id: params[:id])
    @user = @post.user
    @category = Category.find_by(category_id: @post.category_id)
  end
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(
      content: params[:content],
      user_id: @current_user.id,
      numb: params[:numb],
      category_id: params[:category]
      )
    if @post.save
    flash[:notice] = "投稿を作成しました"
    redirect_to("/posts/index")
    else
      render("posts/new")
    end
  end
  
  def edit
    @post = Post.find_by(id: params[:id])
  end
  
  def update
    # updateアクションの中身を作成してください
    @post = Post.find_by(id:params[:id])
    @post.content = params[:content]
    @post.numb = params[:numb]
    
    if @post.save
    flash[:notice] = "投稿を編集しました"
    redirect_to("/posts/index")
    else 
    render("posts/edit")
    end
  end
  
  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to("/posts/index")
  end
  
end
