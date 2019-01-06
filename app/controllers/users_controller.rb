class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update]
    
    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            redirect_to user_path(@user.id)
        else
            render'new'
        end
    end

    
    def show
    end
    
    def edit
    end

    def update
        if @user.update(user_params)
            redirect_to user_path notice:"ユーザーを編集しました"
        else
            render 'edit'
        end
    end

    def favorite
        @user = User.find(params[:id])
        @favorites_blogs = @user.favorites
    end


    private

    def user_params
        params.require(:user).permit(:name, :email, :user_image, :user_image_cache, :password, :password_confirmation)
    end

    def set_user
        @user = User.find(params[:id])
    end
end
