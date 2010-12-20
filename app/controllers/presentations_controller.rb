class PresentationsController < ApplicationController
  
  inherit_resources
  belongs_to :meetup
  respond_to :html
  before_filter :authenticate_user!
  before_filter :set_user, :only => :create

  def index
    if params[:user_id]
      user = User.find(params[:user_id])
      @presentations = user.presentations.all
    else
      @presentations = Presentation.all
    end
  end

  def vote
    @presentation = Presentation.find(params[:id])
    if @presentation.votes.any? { |v| v.user.eql?(current_user) }
      flash[:error] = "Sorry, but you already voted for this presentation"
    elsif @presentation.user.eql?(current_user)
      flash[:error] = "Sorry, you can't vote for your own presentation"
    else
      @presentation.give_vote!(current_user)
      flash[:notice] = "Thank you for you vote!"
    end
    redirect_to :back
  end

  private 
  
  def set_user
   params[:presentation][:user_id] = current_user.id
  end
end
