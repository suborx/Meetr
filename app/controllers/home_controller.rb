class HomeController < ApplicationController
 
  respond_to :html 

  def index
    @meetups = Meetup.find(:all, :order => "happening_at DESC")
    @presentations = Presentation.find(:all, :order => "created_at DESC", :limit => 10)
    @no_title = true
  end

end
