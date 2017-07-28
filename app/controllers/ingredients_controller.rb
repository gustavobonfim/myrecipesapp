class IngredientsController < ApplicationController

  before_action :set_ingredient, only: [:edit, :update, :show]
  before_action :require_logged_in, except: [:show, :index]
  before_action :require_admin, except: [:show, :index]

  def new
    @ingredient = Ingredient.new
  end

  def create
    @ingredient = Ingredient.new(ingredient_params)
    if @ingredient.save
      flash[:success] = "Ingredient successfully created"
      redirect_to ingredient_path(@ingredient)
    else
      render 'new'
    end
  end

  def show
    @ingredient_recipes = @ingredient.recipes.paginate(page: params[:page], per_page: 5)
  end

  def index
    @ingredients = Ingredient.paginate(page: params[:page], per_page: 7)
  end

  def edit

  end

  def update
    if @ingredient.update(ingredient_params)
      flash[:success] = "Ingrediente successfully updated"
      redirect_to ingredient_path(@ingredient)
    else
      render 'edit'
    end
  end

  def destroy

  end

  private

  def set_ingredient
    @ingredient = Ingredient.find(params[:id])
  end

  def ingredient_params
    params.require(:ingredient).permit(:name)
  end

  def require_logged_in
    if !logged_in?
      # flash[:danger] = "You must be logged"
      redirect_to root_path
    end
  end

  def require_admin
    if (logged_in? && !current_chef.admin?)
      flash[:danger] = "Only admin can performace that action"
      redirect_to ingredients_path
    end
  end
end
