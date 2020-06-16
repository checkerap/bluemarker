class TalksController < ApplicationController
  before_action :set_talk, only: [:show, :edit, :update, :destroy]

  # GET /talks
  # GET /talks.json
  def index
    @talks = Talk.all
  end

  # GET /talks/1
  # GET /talks/1.json
  def show
    @papers = Paper.includes(:authors, :paper_files).where(talk: @talk)
  end

  # GET /talks/new
  def new
    @talk = Talk.new
    
    @event = Event.find params[:event]
    @talk.event = @event
    
    @speakers = @talk.event.speakers.order(:name => :asc)
    
    gon.talk_date = Date.today.strftime('%m/%d/%Y %I:%M')
    gon.talk_event_start_date   = @event.start_date
    gon.talk_event_end_date     = @event.end_date
    
    i = 5
    @values = []
    while i <= 300 do
      i = i + 5
      @values << i
    end
    
    p @values
    
  end

  # GET /talks/1/edit
  def edit
    @event = @talk.event
    @speakers = @talk.event.speakers.order(:name => :asc)
    
    # Gon variables for calendar datetime
      date = @talk.date.utc.in_time_zone(@talk.timezone)
      gon.talk_date = "#{date.month}/#{date.day}/#{date.year} #{date.hour}:#{date.min}"
      gon.talk_event_start_date = @event.start_date
      gon.talk_event_end_date = @event.end_date
    # End
    
    i = 5
    @values = []
    while i <= 300 do
      i = i + 5
      @values << i
    end
  end

  # POST /talks
  # POST /talks.json
  def create
    @talk = Talk.new(talk_params)
    @talk.user_id = current_user.id
 
    # date = DateTime.strptime(params[:date_select], '%m/%d/%Y %H:%M %p')  
    # @talk.date = date
    
    form_date = DateTime.strptime(params[:date_select], '%m/%d/%Y %H:%M %p')  
    p "Form date #{form_date}"
    Time.zone = params[:talk][:timezone]
    date = Time.zone.local(form_date.year, form_date.month, form_date.day, form_date.hour, form_date.min, 0)    
    p "Date with timezone #{date}"
    @talk.date = date
    
    respond_to do |format|
      if @talk.save
        format.html { redirect_to @talk, notice: 'Talk was successfully created.' }
        format.json { render :show, status: :created, location: @talk }
      else
        format.html { render :new }
        format.json { render json: @talk.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /talks/1
  # PATCH/PUT /talks/1.json
  def update
    form_date = DateTime.strptime(params[:date_select], '%m/%d/%Y %H:%M %p')  
    p "Form date #{form_date}"
    Time.zone = params[:talk][:timezone]
    date = Time.zone.local(form_date.year, form_date.month, form_date.day, form_date.hour, form_date.min, 0)    
    p "Date with timezone #{date}"
    @talk.date = date
    
    respond_to do |format|
      if @talk.update(talk_params)
        format.html { redirect_to @talk, notice: 'Talk was successfully updated.' }
        format.json { render :show, status: :ok, location: @talk }
      else
        format.html { render :edit }
        format.json { render json: @talk.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /talks/1
  # DELETE /talks/1.json
  def destroy
    @talk.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Talk was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_talk
      @talk = Talk.includes(:speakers, :papers).find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def talk_params
      params.require(:talk).permit(:title, :description, :date, 
      :user_id, :event_id, :timezone, :timespan, 
      :live_video_link, :recorded_video_link, :category_id,
      :speaker_ids => [])
    end
end
