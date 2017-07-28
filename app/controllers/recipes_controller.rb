class RecipesController < ApplicationController

  before_action :set_recipe, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    # @recipes = Recipe.all
    @recipes = Recipe.paginate(page: params[:page], per_page: 5)
  end

  def show
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.chef = current_chef
    if @recipe.save
      flash[:success] = "Recipe was created successfully"
      redirect_to recipe_path(@recipe)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @recipe.update(recipe_params)
      flash[:success] = "Recipe successfully updated"
      redirect_to recipe_path(@recipe)
    else
      render 'edit'
    end
  end

  def destroy
    if @recipe.destroy
      flash[:success] = "Recipe successfully deleted"
      redirect_to recipes_path
    else
      render 'edit'
    end
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:name, :description, ingredient_ids: [])
  end

  def require_same_user
    if current_chef != @recipe.chef and !current_chef.admin?
      flash[:danger] = "You can not performace this action"
      redirect_to root_path
    end
  end
end
