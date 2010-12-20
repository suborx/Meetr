class MeetupsController < ApplicationController

   inherit_resources
   respond_to :html

   before_filter :authenticate_user!, :except => [ :show ]

   create!{ meetups_path }

   def attend
     meetup = Meetup.find(params[:id])
     if meetup.add_attendee(current_user)
       flash[:notice] = "You successfully added yourself to this meetup"
     else
       if meetup.user_attends?(current_user)
         flash[:error] = "You already attending this meetup"
       else
         meetup.update_attendee(current_user, true)
         flash[:notice] = "You successfully added yourself to this meetup"
       end
     end
     redirect_to meetup_path(meetup.id)
   end

   def not_attend
     meetup = Meetup.find(params[:id])
     meetup.add_attendee(current_user)
     meetup.update_attendee(current_user, false)
     flash[:error] = "You successfully removed yourself to this meetup"
     redirect_to meetup_path(meetup.id)
   end

  private

    def begin_of_association_chain
      request.get? ? super : current_user
    end

end
