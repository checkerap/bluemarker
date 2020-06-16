class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy, :talks, :users]
  before_action :authorize_organizer, only: [:new, :create, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
    # @events_current = Event.where('start_date <= ?', Date.today).where('end_date >= ?', Date.today)
    @events_current = Event.all
    @events_upcoming = Event.where('start_date > ?', Date.today) 
    @events_past = Event.where('end_date < ?', Date.today)  
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @days_number = (@event.end_date - @event.start_date + 1).to_i
    @days = []
    (1..@days_number).each do |i|
      day_number = "Day #{i}"
      day_date = @event.start_date + i.days - 1.days
      day_date_explicit = day_date.strftime("%d %b. %Y")
      if day_date < Date.today
        day_status = "inactive"
      elsif day_date == Date.today
        day_status = "current"
      end
      day_resources = {}
      day_resources['day_number'] = day_number
      day_resources['day_date'] = day_date
      day_resources['day_date_explicit'] = day_date_explicit
      day_resources['day_status'] = day_status
      @days << day_resources
    end 
  end

  # GET /events/new
  def new
    @event = Event.new
    @speakers = User.with_role(:speaker).order(:name => :asc)
    
    gon.event_start_date = Date.today
    gon.event_end_date = Date.today
  end

  # GET /events/1/edit
  def edit
    @speakers = User.with_role(:speaker).order(:name => :asc)
    
    gon.event_start_date = @event.start_date
    gon.event_end_date = @event.end_date
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)
    
    # Set event user_id
    @event.user = current_user
    
    # Set event start and end date
    start_date          = Date.strptime(params[:start_date_select], '%m/%d/%y')
    end_date            = Date.strptime(params[:end_date_select], '%m/%d/%y')
    @event.start_date   = start_date
    @event.end_date     = end_date
    
    respond_to do |format|
      if @event.save
        @event.speakers.each do |speaker|
          speaker.add_role :event_speaker, @event
        end
        
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
        # Folosim chestia asta? 
        # user.add_role :moderator, Event.find_by(id: @event.id)
        
        MessageBoard.create(title: @event.title, event_id: @event.id)
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    # Set event start and end date
    start_date          = Date.strptime(params[:start_date_select], '%m/%d/%y')
    end_date            = Date.strptime(params[:end_date_select], '%m/%d/%y')
    @event.start_date   = start_date
    @event.end_date     = end_date
    
    respond_to do |format|
      if @event.update(event_params)
        @event.speakers.each do |speaker|
          speaker.add_role :event_speaker, @event
        end
    
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def talks
    @talks = Talk.where(event_id: @event.id).order(date: :asc)
    
    @days_number = (@event.end_date - @event.start_date + 1).to_i
    @days = []
    (1..@days_number).each do |i|
      day_number = "Day #{i}"
      day_date = @event.start_date + i.days - 1
      if day_date < Date.today
        day_status = "inactive"
      elsif day_date == Date.today
        day_status = "current"
      end
      day_resources = {}
      day_resources['day_number'] = day_number
      day_resources['day_date'] = day_date
      day_resources['day_status'] = day_status
      @days << day_resources
    end 
    
    
    @papers = 0
    @talks.each do |talk|
      talk_papers = Paper.where(talk_id: talk.id).count
      @papers = @papers + talk_papers
    end
  end
  
  def users
    @speakers = @event.speakers
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.includes(:speakers, :talks).find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:title, :summary, :content, 
        :user_id, :start_date, :end_date, :image, 
        :category_id, :video, 
        :speaker_ids => [])
    end
end
