class Administration::ForumGroupsController < AdministrationController
  before_filter :authenticate_admin!
  # GET /forum_groups
  # GET /forum_groups.xml
  def index
    @forum_groups = ForumGroup.all(:order => :position.asc )

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @forum_groups }
    end
  end

  # GET /forum_groups/1
  # GET /forum_groups/1.xml
  def show
    @forum_group = ForumGroup.get(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @forum_group }
    end
  end

  # GET /forum_groups/new
  # GET /forum_groups/new.xml
  def new
    @forum_group = ForumGroup.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @forum_group }
    end
  end

  # GET /forum_groups/1/edit
  def edit
    @forum_group = ForumGroup.get(params[:id])
  end

  # POST /forum_groups
  # POST /forum_groups.xml
  def create
    @forum_group = ForumGroup.new(params[:forum_group])
    logger.debug(@forum_group.to_yaml)

    respond_to do |format|
      if @forum_group.save
        format.html { redirect_to([:administration, @forum_group], :notice => 'Forum group was successfully created.') }
        format.xml  { render :xml => @forum_group, :status => :created, :location => @forum_group }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @forum_group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /forum_groups/1
  # PUT /forum_groups/1.xml
  def update
    @forum_group = ForumGroup.get(params[:id])

    respond_to do |format|
      if @forum_group.update(params[:forum_group])
        format.html { redirect_to([:administration, @forum_group], :notice => 'Forum group was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @forum_group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /forum_groups/1
  # DELETE /forum_groups/1.xml
  def destroy
    @forum_group = ForumGroup.get(params[:id])
    @forum_group.destroy

    respond_to do |format|
      format.html { redirect_to(administration_forum_groups_url) }
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
