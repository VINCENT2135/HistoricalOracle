class CommentsController < ApplicationController
    before_action :set_article
    
    def show
    end
  
    def index
       @comments = Comment.where(article_id: params[:article_id]).paginate(page: params[:page], per_page: 3)
    end
  
    def create  
     @comment = Comment.new(comment_params)
     
            @comment.article = @article
        
            if @comment.save
        
                flash[:notice] = "Comment was successfully created"
        
                    redirect_to article_path(@article)
      
                else
       
                    render 'new'
      
                end	
    end
  
    def new
        @comment = Comment.new
    end
    

    private
      
    def comment_params
      params.require(:comment).permit(:comment)
    end
    
    def set_article
     
     
        if Article.exists?(params[:article_id])
        
            @article = Article.find(params[:article_id])
      else
        
                
                    flash[:error] = "No such article " + params[:article_id]
        
                    redirect_to articles_path
       end
    
    end
    
  end
  