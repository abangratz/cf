class Administration::ForumsController < AdministrationController
  # GET /forums
  # GET /forums.xml
  def index
    @forum_group = ForumGroup.get(params[:forum_group_id])
    @forums = @forum_group.forums

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @forums }
    end
  end

  # GET /forums/1
  # GET /forums/1.xml
  def show
    @forum = Forum.get(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @forum }
    end
  end

  # GET /forums/new
  # GET /forums/new.xml
  def new
    @forum_group = ForumGroup.get(params[:forum_group_id])
    @forum = @forum_group.forums.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @forum }
    end
  end

  # GET /forums/1/edit
  def edit
    @forum = Forum.get(params[:id])
    @forum_group = @forum.forum_group
    @forum.save
  end

  # POST /forums
  # POST /forums.xml
  def create
    @forum_group = ForumGroup.get(params[:forum_group_id])
    @forum = @forum_group.forums.new(params[:forum])

    respond_to do |format|
      if @forum.save
        format.html { redirect_to(edit_administration_forum_group_forum_url(@forum_group,@forum), :notice => 'Forum was successfully created. Please set permissions.') }
        format.xml  { render :xml => @forum, :status => :created, :location => @forum }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @forum.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /forums/1
  # PUT /forums/1.xml
  def update
    @forum = Forum.get(params[:id])

    respond_to do |format|
      if @forum.update(params[:forum]) 
        permissions = params[:permission]
        @forum.forum_roles.each do |forum_role|
          if permissions[forum_role.role_id.to_s]
            forum_role.read = permissions[forum_role.role_id.to_s][:read] == 'yes'
            forum_role.write = permissions[forum_role.role_id.to_s][:write] == 'yes'
            forum_role.moderate = permissions[forum_role.role_id.to_s][:moderate] == 'yes'
            forum_role.save
          end
        end
        format.html { redirect_to(administration_forum_group_forums_url(@forum.forum_group), :notice => 'Forum was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @forum.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /forums/1
  # DELETE /forums/1.xml
  def destroy
    @forum = Forum.get(params[:id])
    @forum_group = @forum.forum_group
    @forum.forum_roles.each do |link|
      link.destroy
    end
    @forum.destroy!

    respond_to do |format|
      format.html { redirect_to(administration_forum_group_forums_url(@forum_group)) }
      format.xml  { head :ok }
    end
  end

  def prioritize
    sort_order = params[:forum_order]
    forum_group = ForumGroup.get(params[:forum_group_id])
    logger.debug(forum_group)
    forums = forum_group.forums
    forums.each {|forum| 
      logger.debug(forum)
      forum.update(
        :position => 
        sort_order.index(forum.id.to_s)+1
      ) 
    }
    respond_to do |format|
      format.js { render :nothing => true, :status => 200 }
    end
  end
end
