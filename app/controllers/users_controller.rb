class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    before_action :require_user, only: [:edit, :update]
    before_action :require_same_user, only: [:edit, :update, :destroy]
  
    def show
   
      @articles = @user.articles.paginate(page: params[:page], per_page: 3)

    end
  
    def index
      @users = User.paginate(page: params[:page], per_page: 3)
    end
  
    def new
      @user = User.new
    end
  
    def edit
    end
  
    def update
      if @user.update(user_params)
        flash[:notice] = "User was updated OK"
        #go to show, have to use _path
        #redirect_to user_path(@user)
        redirect_to user_path(@user) # or @user
        #or can use the shortened path
  
        #redirect_to @article
      else
        render "edit"
      end
    end
  
    def create
      @user = User.new(user_params)
      if @user.save
        session[:user_id] = @user.id # logged in
        flash[:notice] = "Welcome #{@user.username} to the Alpha Blog, you have successfully signed up"
        # redirect_to user_path(@user_path) # or @user
        redirect_to controller: "users", action: "show", id: @user.id
      else
        render 'new'
      end
    end
  
    def destroy
      @user.destroy
      session[:user_id] = nil if @user == current_user
      flash[:notice] = "Account and all associated articles successfully deleted"
      redirect_to articles_path
    end
  
    private
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end
  
    def set_user
      @user = User.find(params[:id])
    end
  
    def require_same_user
      if current_user != @user && !current_user.admin?
        flash[:alert] = "You can only edit or delete your own account"
        redirect_to @user
      end
    end

end

