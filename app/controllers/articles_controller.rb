class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:show, :index]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def show
  
  end

  def index
    
    @articles = Article.paginate(page: params[:page], per_page: 3)
  
  end

  def new
    
    @article = Article.new
  
  end

  def edit
  
  end

  def create
   
    if !article_params["categories_attributes"].nil? &&
        article_params["categories_attributes"]["0"]["name"].empty?
        params[:article].delete :categories_attributes
    end
      @article = Article.new(article_params)
         @article.user = current_user
          if @article.save
              flash[:notice] = "Article was created OK"
              redirect_to article_path(@article)
            else
            render "new"
          end
       end

  def update
    
    if !article_params["categories_attributes"].nil? &&
      article_params["categories_attributes"]["0"]["name"].empty?
      params[:article].delete :categories_attributes
    end
  
          if @article.update(article_params)
      
           flash[:notice] = "Article was updated OK"
      
            redirect_to article_path(@article)
  
              else
      
                render "edit"
    
          end
    end

  def destroy
  
     @article.destroy
    
        redirect_to articles_path
     
   end

  private

  def set_article
    if Article.exists?(params[:id])
	      
        @article = Article.find(params[:id])
	  
      else
	        
        flash[:error] = "No such article " + params[:id]
        
      redirect_to articles_path
 	      
    end
  end

  def article_params

    params.require(:article).permit(:title, :description, category_ids: [], categories_attributes: [:id, :name])
  end

  def require_same_user
    if current_user != @article.user && !current_user.admin?
      flash[:alert] = "You can only edit or delete your own article"
      redirect_to @article
    end
  end

end
