class ChefsController < ApplicationController

  before_action :set_chef, only: [:show, :edit, :update, :destroy]
  before_action :require_user, only: [:edit, :update, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def new
    @chef = Chef.new
  end

  def create
    @chef = Chef.new(chef_params)
    if @chef.save
      session[:chef_id] = @chef.id
      flash[:success] = "Welcome #{@chef.chefname} to MyRecipes"
      redirect_to chef_path(@chef)
      # redirect_to chefs_path(@chef)
    else
      render 'new'
    end
  end

  def show
    @first_name = first_name(@chef.chefname)
    @chef_recipes = @chef.recipes.paginate(page: params[:page], per_page: 5)
  end

  def edit
    @first_name = first_name @chef.chefname
  end

  def update
    if @chef.update(chef_params)
      flash[:success] = "Your profile was successfully updated"
      redirect_to @chef
    else
      render 'chefs/edit'
    end
  end

  def index
    @chefs = Chef.paginate(page: params[:page], per_page: 3)
  end

  def destroy
    @chef.destroy
    # redirect_to url_for(:controller => :controller_name, :action => :action_name)
    # destroy_session_after_delete_chef
    redirect_to root_path
    flash[:danger] = "Chef and all recipes have been deleted"
  end

  private

  def chef_params
    params.require(:chef).permit(:chefname, :email, :password, :password_confirmation)
  end

  def first_name(name)
    first_name = name.split(' ')[0]
  end

  def set_chef
    @chef = Chef.find(params[:id])
  end

  def require_same_user
    if current_chef != @chef
      flash[:danger] = "You can not performace this action"
      redirect_to root_path
    end
  end


end
