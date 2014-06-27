class Admin::HomesController < ApplicationController
	before_filter :set_event, only: :events

	def events
		@events = Event.all
	end

	def create_event
		@event = Event.create(event_params)
		@event.status = "Upcoming"
	    respond_to do |format|
	      if @event.save
	        format.html { redirect_to events_admin_homes_path, notice: 'Event was successfully created.' }
	      else
	        format.html { redirect_to events_admin_homes_path, alert: 'Event creation shows error. Please try again.' }
	      end
	    end
	end

	def edit
		@event = Event.find(params[:id])
	end

	def update
		@event = Event.find(params[:id])
	    if @event.update_attributes(event_params)
	      flash[:notice] = "Event Info Updated."
	      redirect_to events_admin_homes_path
	    else
	      flash[:alert] = @event.errors.messages
	      redirect_to :back
	    end
	end

	def change_status
		@event = Event.find(params[:id])
		@event.status = @event.status == "Upcoming" ? "Ongoing" : "Completed"
		@event.save
		redirect_to events_admin_homes_path
	end

	def audition
		params[:id] = 1
		@event = Event.find(params[:id])
		@users = @event.users
	end

	def save_json_data
		p "(((((((((((((((((((((((9"
			p params
  	render :json => {:data => {:hang_out_url => params[:hangoutUrl], :topic => params[:topic]}}
  	user_id = params[:id].split('@')
  	@user = User.find(user_id[0].to_i)
  	@user.update_attributes(hangouturl: params[:hangoutUrl])
  end

	private

	def set_event
		@event = Event.new
	end

	def event_params
      params.require(:event).permit(:name, :about, :rules, :category, :first_prize_info, :second_prize_info, :third_prize_info, :audition_start_datetime, :audition_end_datetime, :cover_pic_url)
    end
end
