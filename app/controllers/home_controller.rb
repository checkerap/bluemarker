class HomeController < ApplicationController
  
  def index
    # @events_current = Event.where('start_date <= ?', Date.today).where('end_date >= ?', Date.today)
    @events_current = Event.all.limit(3)
    @events = Event.all
    
    @news = News.last(3)
  end
  
  def private
  end

end