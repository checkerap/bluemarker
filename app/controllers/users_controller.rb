class UsersController < ApplicationController
  require 'smarter_csv'
  before_action :authorize_organizer, only: [:index, :new, :create, :edit, :update, :destroy, :upload, :import]
  
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
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
      
      flash[:notice] = "User created."
      redirect_to users_path
    else
      flash[:notice] = "Something went wrong."
      redirect_to users_path
    end
  end
  
  def update
    @user = User.find(params[:id])
    @user.update_attributes(user_params)
    if @user.save 
      if image_params.present?
        image = ActiveStorage::Attachment.find(@user.image.id)
        image.purge
          
        @user.image.attach(image_params)
      end
      
      flash[:notice] = "User updated."
      redirect_to users_path
    else 
      flash[:notice] = "Something went wrong."
      redirect_to users_path
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
  
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :name, :title, :country, :city, :organization, :timezone, :link_website, :link_youtube, :link_facebook, :link_linkedin, :link_twitter )
    end
    
    def image_params
      params.dig(:user, :image)
    end
end