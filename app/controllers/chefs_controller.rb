class ChefsController < ApplicationController

  def new
    @chef = Chef.new
  end

  def create
    @chef = Chef.new(chef_params)
    if @chef.save
      flash[:success] = "Welcome #{@chef.chefname} to MyRecipes"
      redirect_to chef_path(@chef)
      # redirect_to chefs_path(@chef)
    else
      render 'new'
    end
  end

  def show
    @chef = Chef.find(params[:id])
    @first_name = first_name(@chef.chefname)
  end

  def edit
    @chef = Chef.find(params[:id])
    @first_name = first_name @chef.chefname
  end

  def update
    @chef = Chef.find(params[:id])

    if @chef.update(chef_params)
      flash[:success] = "Your profile was successfully updated"
      redirect_to @chef
    else
      render 'chefs/edit'
    end
  end



  private

  def chef_params
    params.require(:chef).permit(:chefname, :email, :password, :password_confirmation)
  end

  def first_name(name)
    first_name = name.split(' ')[0]
  end


end
