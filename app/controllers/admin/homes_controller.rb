class Admin::HomesController < ApplicationController
	before_filter :set_event, only: :events
  before_filter :set_access_control_headers, only: :save_json_data

  def set_access_control_headers 
    headers['Access-Control-Allow-Origin'] = '*' 
    headers['Access-Control-Request-Method'] = '*' 
  end

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
		url = @event.status == "Ongoing" ? audition_admin_home_path(@event) : events_admin_homes_path
		redirect_to url 
	end

	def audition
		@event = Event.find(params[:id])
		@users = @event.users
	end

	def save_json_data
    user_id = params[:id].split('@')
    @user = User.find(user_id[0].to_i)
    @user.update_attributes(hangouturl: params[:hangoutUrl])
  	render :json => {:data => {:hang_out_url => params[:hangoutUrl], :topic => params[:topic]}}
  end

  def destroy
  	@event = Event.find(params[:id])
  	@event.destroy
  	redirect_to events_admin_homes_path
  end

	private

	def set_event
		@event = Event.new
	end

	def event_params
      params.require(:event).permit(:name, :about, :rules, :category, :first_prize_info, :second_prize_info, :third_prize_info, :audition_start_datetime, :audition_end_datetime, :cover_pic_url)
    end

    def check_role
    	user = User.find(session[:current_user])
    	redirect_to root_path and return unless user.role == "admin"
    end
end
