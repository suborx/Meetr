class UsersController < ApplicationController

  def update
    @user = current_user
    if @user.update_attributes(:email => params[:user][:email])
      redirect_to root_path {:notice] = "Your profile has been updated."}
    else
      render :action => 'edit'
    end
  end

end
