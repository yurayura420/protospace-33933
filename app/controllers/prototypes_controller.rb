class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  before_action :set_prototypes, only: [:edit, :show]
  before_action :move_to_index, only: [:edit]
  def index
    @prototypes = Prototype.find_by_sql("SELECT * FROM prototypes")
  end

  def new
    @prototype = Prototype.new
  end
  
  def create
    if Prototype.create(prototype_params)
      redirect_to root_path
    else
      render :new
    end    
  end  

  def show
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end  

  def edit
  end
  
  def update
    prototype = Prototype.find(params[:id])
    if prototype.update(prototype_params)
      redirect_to prototype_path(prototype.id)
    else
      render :edit
    end    
  end   

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end  


  private
  def prototype_params
    params.require(:prototype).permit(:image,:title,:catch_copy,:concept).merge(user_id: current_user.id)
  end  
  def set_prototypes
    @prototype = Prototype.find(params[:id])
  end  

  def move_to_index
    unless user_signed_in? && @prototype.user.id == current_user.id
      redirect_to action: :index
    end
  end
end
