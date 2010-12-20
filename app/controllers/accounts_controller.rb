class AccountsController < ApplicationController

  respond_to :html
  before_filter :authenticate_user!, :except => [ :show ]

  def update
    account = current_user.account
    account.update_attributes!(params[:account])
    redirect_to account_url(account.id), {:notice => "Your profile was updated!"}
  end

  def show
    @account = Account.find(params[:id])
  end

end
