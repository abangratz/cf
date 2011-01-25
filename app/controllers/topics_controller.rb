class TopicsController < ApplicationController
  before_filter :authenticate_user!
  # GET /topics/1
  # GET /topics/1.xml
  def show
    @topic = Topic.get(params[:id])

    marked_topic = MarkedTopic.first_or_create({:topic_id => @topic.id, :user_id => current_user.id})
    marked_topic.last_read = Time.now
    marked_topic.save

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @topic }
    end
  end

  # GET /topics/new
  # GET /topics/new.xml
  def new
    @forum_group = ForumGroup.get(params[:forum_group_id])
    @forum= Forum.get(params[:forum_id])
    @topic = @forum.topics.new

    respond_to do |format|
      format.html {
        redirect_to [@topic.forum.forum_group, @topic.forum], :notice => "Not allowed!" unless current_user.can_write(@topic.forum)
      }
      format.xml  { render :xml => @topic }
    end
  end

  # GET /topics/1/edit
  def edit
    @topic = Topic.get(params[:id])
    redirect_to [@topic.forum.forum_group, @topic.forum], :notice => "Not allowed!" unless current_user.can_write(@topic.forum)
    redirect_to @topic, :notice => "Topic locked!" if @topic.locked
  end

  # POST /topics
  # POST /topics.xml
  def create
    @forum_group = ForumGroup.get(params[:forum_group_id])
    @forum= Forum.get(params[:forum_id])
    redirect_to [@forum_group, @forum], :notice => "Not allowed!" unless current_user.can_write(@forum)
    @topic = @forum.topics.new(params[:topic])
    @topic.author = current_user

    respond_to do |format|
      if @topic.save
        format.html { redirect_to([@forum_group,@forum], :notice => 'Topic was successfully created.') }
        format.xml  { render :xml => @topic, :status => :created, :location => @topic }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @topic.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /topics/1
  # PUT /topics/1.xml
  def update
    @topic = Topic.get(params[:id])
    redirect_to [@topic.forum.forum_group, @topic.forum], :notice => "Not allowed!" unless current_user.can_write(@topic.forum)

    respond_to do |format|
      if @topic.update(params[:topic])
        format.html { redirect_to(@topic, :notice => 'Topic was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @topic.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.xml
  def destroy
    @topic = Topic.get(params[:id])
    redirect_to [@topic.forum.forum_group, @topic.forum], :notice => "Not allowed!" unless current_user.can_write(@topic.forum)
    @topic.destroy

    respond_to do |format|
      format.html { redirect_to([@topic.forum.forum_group, @topic.forum]) }
      format.xml  { head :ok }
    end
  end

  def sticky
    @topic = Topic.get(params[:id])
    redirect_to [@topic.forum.forum_group, @topic.forum], :notice => "Not allowed!" unless current_user.can_write(@topic.forum)
    respond_to do |format|
      if @topic.update(:sticky => true)
        format.html { redirect_to(@topic, :notice => 'Topic was successfully stickied.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @topic.errors, :status => :unprocessable_entity }
      end
    end
  end

  def unsticky
    @topic = Topic.get(params[:id])
    redirect_to [@topic.forum.forum_group, @topic.forum], :notice => "Not allowed!" unless current_user.can_write(@topic.forum)
    respond_to do |format|
      if @topic.update(:sticky => false)
        format.html { redirect_to(@topic, :notice => 'Topic was successfully unstickied.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @topic.errors, :status => :unprocessable_entity }
      end
    end
  end

  def lock
    @topic = Topic.get(params[:id])
    redirect_to [@topic.forum.forum_group, @topic.forum], :notice => "Not allowed!" unless current_user.can_write(@topic.forum)
    respond_to do |format|
      if @topic.update(:locked => true)
        format.html { redirect_to(@topic, :notice => 'Topic was successfully locked.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @topic.errors, :status => :unprocessable_entity }
      end
    end
  end

  def unlock
    @topic = Topic.get(params[:id])
    redirect_to [@topic.forum.forum_group, @topic.forum], :notice => "Not allowed!" unless current_user.can_write(@topic.forum)
    respond_to do |format|
      if @topic.update(:locked => false)
        format.html { redirect_to(@topic, :notice => 'Topic was successfully unlocked.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @topic.errors, :status => :unprocessable_entity }
      end
    end
  end
end
