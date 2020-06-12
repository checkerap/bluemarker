class UsersController < ApplicationController
  require 'smarter_csv'
  before_action :authorize_organizer, only: [:index, :new, :create, :destroy, :upload, :import]
  before_action :authorize_edit, only: [:edit, :update]
  
  def index
    @users = User.all
  end
  
  def show
    @user = User.includes(:events_as_speaker, :events_as_attendee, :talks).find params[:id]
    if (@user.link_facebook.present? or @user.link_linkedin.present? or @user.link_twitter.present? or @user.link_website.present? or @user.link_youtube.present?)
      @social = true
    end
    @events = Event.with_role(:event_speaker, @user)
    
    
    
  end
  
  def upload
  end
  
  def new
    @user = User.new
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      @user.image.attach(image_params) if image_params.present?
      
      if params[:user_role] == "speaker"
        @user.add_role :speaker
      elsif params[:user_role] == "attendee"
        @user.add_role :attendee
      end
      
      flash[:notice] = "User created."
      redirect_to "/users/#{@user.id}"
    else
      flash[:notice] = "Something went wrong."
      render :edit
    end
  end
  
  def update
    @user = User.find(params[:id])
    @user.update_attributes(user_params)
    if @user.save 
      if image_params.present?
        if @user.image.attached?
          image = ActiveStorage::Attachment.find @user.image.id
          image.purge if image
        end
          
        @user.image.attach(image_params)
      end
      
      if params[:user_role] == "speaker"
        @user.add_role :speaker
      elsif params[:user_role] == "attendee"
        @user.add_role :attendee
      end
      
      flash[:notice] = "User updated."
      redirect_to "/users/#{@user.id}"
    else 
      flash[:notice] = "Something went wrong."
      render :edit
    end 
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = "User deleted."
    redirect_to '/users'
  end
  
  def import
    upload = params[:file]
    if upload.present? 
      @users = SmarterCSV.process(upload.tempfile)
      @users.each do |user|
        user = User.create(name: user[:name], email: user[:email], password: "newpassword")
        
        p params[:user_role]
        
        if params[:user_role] == "speaker"
          user.add_role :speaker
        elsif params[:user_role] == "attendee"
          user.add_role :attendee
        end
      end
      redirect_to "/users/upload", notice: "Users imported."
    else
      redirect_to "/users/upload", notice: "File not present."
    end
  end
  
  private
    
    def authorize_edit
      @user = User.find(params[:id])
      if current_user.present? 
        return unless (!current_user.has_role? :organizer or current_user.id == @user.id )
        redirect_to root_path, alert: "You don't have enough rights."
      else
        redirect_to root_path, alert: 'You are not signed in'  
      end
    end
    
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :name, :title, :country, :city, :organization, :timezone, :link_website, :link_youtube, :link_facebook, :link_linkedin, :link_twitter, :bio)
    end
    
    def image_params
      params.dig(:user, :image)
    end
end