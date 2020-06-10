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
    @talks = Talk.where(event_id: @talk.event_id).where.not(id: @talk.id).order(date: :asc)
    @papers = Paper.where(talk_id: @talk.id)
  end

  # GET /talks/new
  def new
    @event = Event.find(params[:event])
    @talk = Talk.new
    
    gon.talk_date = Date.today
    gon.talk_event_start_date = @event.start_date
    gon.talk_event_end_date = @event.end_date
  end

  # GET /talks/1/edit
  def edit
    @event = Event.find(@talk.event_id)
    
    # Gon variables for calendar datetime
      date = @talk.date.utc.in_time_zone(@talk.timezone)
      gon.talk_date = "#{date.month}/#{date.day}/#{date.year} #{date.hour}:#{date.min}"
      gon.talk_event_start_date = @event.start_date
      gon.talk_event_end_date = @event.end_date
    # End
  end

  # POST /talks
  # POST /talks.json
  def create
    @talk = Talk.new(talk_params)
    @talk.user_id = current_user.id
    
    date = DateTime.strptime(params[:date_select], '%m/%d/%y %H:%M %p')  
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
    Time.zone = params[:talk][:timezone]
    date = Time.zone.local(form_date.year, form_date.month, form_date.day, form_date.hour, form_date.min, 0)    
    p date
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
      @talk = Talk.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def talk_params
      params.require(:talk).permit(:title, :description, :date, :user_id, :event_id, :timezone, :timespan, :category_id)
    end
end
