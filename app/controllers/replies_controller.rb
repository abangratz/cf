class RepliesController < ApplicationController
  before_filter :authenticate_user!
  # GET /replies
  # GET /replies.xml
  def index
    @replies = Reply.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @replies }
    end
  end

  # GET /replies/1
  # GET /replies/1.xml
  def show
    @reply = Reply.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @reply }
    end
  end

  # GET /replies/new
  # GET /replies/new.xml
  def new
    @topic = Topic.get(params[:topic_id])
    redirect_to [@topic.forum.forum_group, @topic.forum], :notice => "Not allowed!" unless current_user.can_write(@topic.forum)
    @reply = @topic.replies.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @reply }
    end
  end

  # GET /replies/1/edit
  def edit
    @topic = Topic.get(params[:topic_id])
    redirect_to @topic, :notice => "Not allowed!" unless current_user.can_write(@topic.forum)
    redirect_to @topic, :notice => "Topic locked!" if @topic.locked
    @reply = Reply.get(params[:id])
  end

  # POST /replies
  # POST /replies.xml
  def create
    @topic = Topic.get(params[:topic_id])
    redirect_to @topic, :notice => "Not allowed!" unless current_user.can_write(@topic.forum)
    @reply = @topic.replies.new(params[:reply])
    @reply.author = current_user

    respond_to do |format|
      if @reply.save
        format.html { redirect_to(@topic , :notice => 'Reply was successfully created.') }
        format.xml  { render :xml => @reply, :status => :created, :location => @reply }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @reply.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /replies/1
  # PUT /replies/1.xml
  def update
    @topic = Topic.get(params[:topic_id])
    redirect_to [@topic.forum.forum_group, @topic.forum], :notice => "Not allowed!" unless current_user.can_write(@topic.forum)
    @reply = Reply.get(params[:id])

    respond_to do |format|
      if @reply.update_attributes(params[:reply])
        format.html { redirect_to(@topic, :notice => 'Reply was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @reply.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /replies/1
  # DELETE /replies/1.xml
  def destroy
    @reply = Reply.find(params[:id])
    @reply.destroy

    respond_to do |format|
      format.html { redirect_to(replies_url) }
      format.xml  { head :ok }
    end
  end
end
