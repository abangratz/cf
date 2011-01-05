class TopicsController < ApplicationController
  before_filter :authenticate_user!
  # GET /topics
  # GET /topics.xml
  def index
    @topics = Topic.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @topics }
    end
  end

  # GET /topics/1
  # GET /topics/1.xml
  def show
    @topic = Topic.get(params[:id])

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
      format.html # new.html.erb
      format.xml  { render :xml => @topic }
    end
  end

  # GET /topics/1/edit
  def edit
    @topic = Topic.get(params[:id])
  end

  # POST /topics
  # POST /topics.xml
  def create
    @forum_group = ForumGroup.get(params[:forum_group_id])
    @forum= Forum.get(params[:forum_id])
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
    @topic.destroy

    respond_to do |format|
      format.html { redirect_to(topics_url) }
      format.xml  { head :ok }
    end
  end
end
