class HomeController < ApplicationController
  layout 'login', only: :login
  before_filter :login_required, except: [:login, :new]

	def index
    p session[:current_user]
    p "kkkkkkkkkkkkkkkkkkkk"
    @upcoming_events = Event.where(:status => "Upcoming")
    @ongoing_events = Event.where(:status => "Ongoing")
    @results = Event.where(:status => "Completed")
	end

	def show
  end

  def login
  end

  def upcoming
    @upcoming_events = Event.where(:status => "Upcoming")
  end

  def ongoing
    @ongoing_events = Event.where(:status => "Ongoing")
  end

  def results
    @results = Event.where(:status => "Completed")
  end

  def profile
    @user = User.find(params[:id])
  end

  def profile_create
    @user = User.find(params[:id])
    updated = @user.update_attributes(user_params)
    if updated
      if @user.avatar_file_name == nil and @user.user_cloud_url == nil
        @user.update_attribute(:user_cloud_url, "http://ensemble.stanford.edu/assets/default_profile-d80441a6f25a9a0aac354978c65c8fa9.jpg")
      elsif @user.avatar_file_name != nil 
        #connecting with AWS cloud
        @file_update = @user.fog(@user.avatar.url)

        @user.update_attribute(:user_cloud_url, @file_update.public_url)
      end
    end

    redirect_to home_index_path
  end

  def new
    user = User.find_by_gplus(params[:gplus])
    if user
      session[:current_user] = user.id
      redirect_to landing_home_index_path, notice: "You are already registered!"
    else
      @fullname = params[:fullname]
      @gplusId = params[:gplus]
      u = User.new(:name => params[:fullname], :gplus => params[:gplus], :email=> params[:email])
      if u.save
        session[:current_user] = u.id
       redirect_to profile_home_path(u), notice: "User with name #{@fullname} and Google+ ID #{@gplusId} has been successfully registered!"
      else
        redirect_to root_path and return  
      end
    end
  end

  def edit
  end

  def participate_event
    p session[:current_user]
    p "kkkkkkkkkkkkkkk"
    @event = Event.find(params[:id])
    @participant = UserEvent.create(:event_id => @event.id, :user_id => session[:current_user]) if @event
    redirect_to upcoming_home_index_path
  end

  def create
    authorize! :create, @user, :message => 'Not authorized as an administrator.'

    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    authorize! :update, @user, :message => 'Not authorized as an administrator.'
    respond_to do |format|

      if @user.update_attributes(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    authorize! :destroy, @user, :message => 'Not authorized as an administrator.'

    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
    end
  end

  def about_us
    
  end

  def my_events
    current_user = User.find session[:current_user]
    @events = current_user.events
  end

  def event_details
    @event = Event.find params[:id]
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :first_name, :last_name, :roles => [])
    end

    def login_required
      if session[:current_user].nil?
        redirect_to root_path and return
      end
    end
end
