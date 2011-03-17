class CalendarEventsController < ApplicationController
  # GET /calendar_events
  # GET /calendar_events.xml
  def index
    @calendar_eventses = CalendarEvent.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @calendar_eventses }
    end
  end

  # GET /calendar_events/1
  # GET /calendar_events/1.xml
  def show
    @calendar_event = CalendarEvent.get(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @calendar_event }
    end
  end

  # GET /calendar_events/new
  # GET /calendar_events/new.xml
  def new
    @calendar_event = CalendarEvent.new

    respond_to do |format|
      format.html # new.html.erb
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
    @calendar_event = CalendarEvent.new(params[:calendar_event])

    respond_to do |format|
      if @calendar_event.save
        format.html { redirect_to(@calendar_event, :notice => 'Calendar event was successfully created.') }
        format.xml  { render :xml => @calendar_event, :status => :created, :location => @calendar_event }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @calendar_event.errors, :status => :unprocessable_entity }
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
      format.html { redirect_to(calendar_eventses_url) }
      format.xml  { head :ok }
    end
  end
end
