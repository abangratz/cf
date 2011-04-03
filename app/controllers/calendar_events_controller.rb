class CalendarEventsController < ApplicationController
  before_filter :authenticate_user!
  # GET /calendar_events
  # GET /calendar_events.xml
  def index
    if params[:start] && params[:end]
      the_range = Time.at(params[:start].to_i)..Time.at(params[:end].to_i)
      @calendar_events = CalendarEvent.all(:start => the_range)
    else
      @calendar_events = CalendarEvent.all
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @calendar_events }
      format.json  { render :json => @calendar_events }
    end
  end

  # GET /calendar_events/1
  # GET /calendar_events/1.xml
  def show
    @calendar_event = CalendarEvent.get(params[:id])
    @subscription = Subscription.first(:calendar_event => @calendar_event, :character => {:profile =>{:user => current_user}}) || @calendar_event.subscriptions.new

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @calendar_event }
    end
  end

  # GET /calendar_events/new
  # GET /calendar_events/new.xml
  def new
    @calendar_event = CalendarEvent.new(params[:event])
    logger.debug @calendar_event.start

    respond_to do |format|
      format.html { render :layout => false }
      format.xml  { render :xml => @calendar_event }
    end
  end

  # GET /calendar_events/1/edit
  def edit
    @calendar_event = CalendarEvent.get(params[:id])
  end

  # POST /calendar_events
  # POST /calendar_events.xml
  def create
    params[:calendar_event][:start] = params[:start_date] + ' ' + params[:start_time]
    params[:calendar_event][:end] = params[:end_date] + ' ' + params[:end_time]
    @calendar_event = CalendarEvent.new(params[:calendar_event])
    @calendar_event.user = current_user

    respond_to do |format|
      if @calendar_event.save
        format.html { redirect_to(@calendar_event, :notice => 'Calendar event was successfully created.') }
        format.xml  { render :xml => @calendar_event, :status => :created, :location => @calendar_event }
        format.json { render :json => @calendar_event, :status => :created }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @calendar_event.errors, :status => :unprocessable_entity }
        format.json { render :json => @calendar_event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /calendar_events/1
  # PUT /calendar_events/1.xml
  def update
    @calendar_event = CalendarEvent.get(params[:id])

    respond_to do |format|
      if @calendar_event.update(params[:calendar_event])
        format.html { redirect_to(@calendar_event, :notice => 'Calendar event was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @calendar_event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /calendar_events/1
  # DELETE /calendar_events/1.xml
  def destroy
    @calendar_event = CalendarEvent.get(params[:id])
    @calendar_event.destroy

    respond_to do |format|
      format.html { redirect_to(calendar_events_url) }
      format.xml  { head :ok }
    end
  end
end
