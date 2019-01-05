class BlogsController < ApplicationController
    before_action :set_blog, only: [:show, :edit, :update, :destroy]
    before_action :require_login, only:[:edit, :destroy, :show, :new, :index]
    def index
        @blogs = Blog.all
    end

    def new
        if params[:back]
            @blog = Blog.new(blog_params)
        else
            @blog = Blog.new
        end
    end

    def create
        Blog.create(blog_params)
        if @blog.save
            BlogMailer.blog_mail(@blog).deliver
            redirect_to blogs_path,notice:" 新規投稿しました！"
        else
            render'new'
        end
    end

    def show
    end

    def edit
    end

    def destroy
        @blog.destroy
        redirect_to blogs_path, notice:"削除しました！"
    end

    def confirm
        @blog = Blog.new(blog_params)
        render :new if @blog.invalid?
    end


    def update
        if @blog.update(blog_params)
            redirect_to blogs_path, notice:"編集しました！"
        else
            render'edit'
        end
    end 

    private

    def blog_params
        params.require(:blog).permit(:title, :content)
    end

    def set_blog
        @blog = Blog.find(params[:id])
    end 

    def require_login
        unless logged_in?
            redirect_to new_session_path,notice:"ログインしてください"
        end
    end
end
