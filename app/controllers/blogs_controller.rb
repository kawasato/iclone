class BlogsController < ApplicationController
    before_action :set_blog, only: [:show, :edit, :update, :destroy]
    before_action :require_login, only:[:edit, :destroy, :show, :new, :index]
    PER = 8
    
    def index
        @blogs = Blog.page(params[:page]).per(PER)
    end

    def new
        if params[:back]
            @blog = Blog.new(blog_params)
        else
            @blog = Blog.new
        end
    end

    def create
        @blog = Blog.new(blog_params)
        @blog.user_id = current_user.id
        if @blog.save
            BlogMailer.blog_mail(@blog).deliver
            redirect_to blogs_path,notice:" 新規投稿しました！"
        else
            render'new'
        end
    end

    def show
        @favorite = current_user.favorites.find_by(blog_id: @blog.id)
    end

    def edit
    end

    def destroy
        @blog.destroy
        redirect_to blogs_path, notice:"削除しました！"
    end

    def confirm
        @blog = Blog.new(blog_params)
        @blog.user_id = current_user.id
        render :new if @blog.invalid?
    end


    def update
        if @blog.update(blog_params)
            redirect_to blogs_path, notice:"編集しました！"
        else
            render'edit'
        end
    end 

    def search
        blog_search = Blog.new(params_blog_search)
        @blogs = blog_search.execute
    end

    #def favorite 
        #@user = User.find(params[:id])
        #@favorites_blogs = @user.favorites
    #end

    private

    def blog_params
        params.require(:blog).permit(:title, :content,:blog_image,:blog_image_cache)
    end

    def set_blog
        @blog = Blog.find(params[:id])
    end 

    def require_login
        unless logged_in?
            redirect_to new_session_path,notice:"ログインしてください"
        end
    end

    def params_blog_search
        params.permit(:search_blog)
      end
end
