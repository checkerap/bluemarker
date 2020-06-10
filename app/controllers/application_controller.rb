class ApplicationController < ActionController::Base
  
  private
  
  # Authorize different user roles
  def authorize_organizer
    if current_user.present? 
      return unless !current_user.has_role? :organizer
      redirect_to root_path, alert: "You don't have enough rights."
    else
      redirect_to root_path, alert: 'You are not signed in'  
    end
  end
  
  def authorize_speaker
    if current_user.present? 
      return unless !current_user.has_role? :speaker
      redirect_to root_path, alert: "You don't have enough rights."
    else
      redirect_to root_path, alert: 'You are not signed in.'  
    end
  end
  
  def authorize_attendee
    if current_user.present? 
      return unless !current_user.has_role? :attendee
      redirect_to root_path, alert: "You don't have enough rights."
    else
      redirect_to root_path, alert: 'You are not signed in.'  
    end
  end
  
end
