class Administration::PagesController < AdministrationController
  # GET /pages
  # GET /pages.xml
  def index
    @pages = Page.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pages }
    end
  end

  # GET /pages/1
  # GET /pages/1.xml
  def show
    @page = Page.first(:slug => params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @page }
    end
  end

  # GET /pages/new
  # GET /pages/new.xml
  def new
    @page = Page.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @page }
    end
  end

  # GET /pages/1/edit
  def edit
    @page = Page.first(:slug => params[:id])
  end

  # POST /pages
  # POST /pages.xml
  def create
    @page = Page.new(params[:page])
    @page.admin = current_admin

    respond_to do |format|
      if @page.save
        format.html { redirect_to([:administration,@page], :notice => 'Page was successfully created.') }
        format.xml  { render :xml => @page, :status => :created, :location => @page }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pages/1
  # PUT /pages/1.xml
  def update
    @page = Page.first(:slug => params[:id])
    @page.admin = current_admin

    respond_to do |format|
      if @page.update(params[:page])
        format.html { redirect_to([:administration,@page], :notice => 'Page was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.xml
  def destroy
    @page = Page.first(:slug => params[:id])
    @page.destroy

    respond_to do |format|
      format.html { redirect_to(administration_pages_url) }
      format.xml  { head :ok }
    end
  end

  def prioritize
    sort_order = params[:forum_group_order]
    forum_groups = ForumGroup.all
    forum_groups.each {|group| 
      group.update(
        :position => 
        sort_order.index(group.id.to_s)+1
      ) 
    }
    respond_to do |format|
      format.js { render :nothing => true, :status => 200 }
    end
  end
end
