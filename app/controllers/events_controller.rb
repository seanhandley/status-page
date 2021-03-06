class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    @statuses = get_statuses()
    #Depending on the event type we call the get_events_comments function to return the
    #required events and comments, we then set the partial we want to add to our index page
    if params["event_type"] == "resolved"
      @events, @comments = get_events_and_comments("resolved")
      @partial_to_get = "resolved"
    elsif params["event_type"] == "scheduled"
      @events, @comments = get_events_and_comments("scheduled")
      @partial_to_get = "scheduled"
    elsif params["event_type"] == "feed"
      @events, @comments = get_events_and_comments("feed")
    else
      @events, @comments = get_events_and_comments("active")
      @partial_to_get = "active"
    end   
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    if user_signed_in?
      @event = Event.new
      @statuses = get_statuses()
    else
      redirect_to action: "index"
    end
  end

  # GET /events/1/edit
  def edit
    if user_signed_in?
      #We want to have a new comment available on editing
      @event.comments.build
      @current_time = get_current_time() #We need the current time for updates
      @statuses = get_statuses()
    else
      redirect_to action: "index"
    end
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)
    @statuses = get_statuses()

    respond_to do |format|
      if @event.save
        format.html { redirect_to action: "index", notice: 'Event was successfully created.' } #Return to index on updating rather than show
        format.json { render action: 'show', status: :created, location: @event }
      else
        format.html { render action: 'new' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to action: 'index', notice: 'Event was successfully updated.' } #Return to index on updating rather than show
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:title, :content, :event_date, :updated_at, :resolved_at, :resolved, :status_id, comments_attributes: [:event_id, :comment, :added_by, :id, :_destroy])
    end
    
    #Our function for pulling the events and comments we need
    def get_events_and_comments(event_type)
      #Get current time and date
      current_time = get_current_time()
      
      #Run required query
      if event_type == "resolved"
        #events = Event.find_by_sql("SELECT * FROM events WHERE resolved = 't'")
        events = Event.where(resolved: 't').order(:resolved_at).reverse_order.page(params[:page]).per(4)
      elsif event_type == "scheduled"
        events = Event.find_by_sql("SELECT * FROM events WHERE resolved = 'f' AND event_date > '#{current_time}'")
      elsif event_type == "feed"
        events = Event.where(resolved: 'f')
      else
        events = Event.find_by_sql("SELECT * FROM events WHERE resolved = 'f' AND event_date <= '#{current_time}'")
      end
      
      #get an array of event ids for our comments query
      event_ids = []
      events.each do |event|
        event_ids.push(event.id)
      end
      #Get commnets for our events
      comments = Comment.where(event_id: event_ids).order(:created_at).reverse_order
      
      #return our results
      return events, comments
    end
    
    def get_current_time()
      current_time = Time.new
      current_time = current_time.strftime("%Y-%m-%d %H:%M:%S")
      return current_time
    end
    
    #function for setting our statuses correctly
    def get_statuses()
      statuses = Status.find_by_sql("SELECT id, name, colour FROM statuses")
      return statuses
    end
  end
