class SessionsController < ApplicationController
  def create
    @current_user = User.find(12) if params[:login] == 'Peter' && params[:password] == 'hans'
    
    if @current_user
      session[:user_id] = @current_user.id
      if session[:return_to]
        redirect_to session[:return_to]
        session[:return_to] = nil
      else    
      redirect_to rawstories_path
      end
    else
      render :action => 'new'
    end
      
  end

  def new
  end

  def destroy
    session[:user_id] = @current_user = nil
  end

end
