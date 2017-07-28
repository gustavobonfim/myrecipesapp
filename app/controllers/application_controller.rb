class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  #to make methods available in the views
  helper_method :current_chef, :logged_in?, :look_name_current_chef

  def current_chef
    @current_chef ||= Chef.find(session[:chef_id]) if session[:chef_id]
  end

  def logged_in?
    !!current_chef
  end

  def require_user
    if !logged_in?
      flash[:danger] = "You must be logged in to performace the action"
      redirect_to root_path
    end
  end

  def destroy_session_after_delete_chef
    session[:chef_id] = nil
    session = {}    
  end

  def look_name_current_chef
    if current_chef.nil?
      @name_currente_chef = "There is no one"
    else
      @name_currente_chef = @current_chef.chefname
    end
    return @name_currente_chef
  end
end
