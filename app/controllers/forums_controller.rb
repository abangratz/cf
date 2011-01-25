class ForumsController < ApplicationController
  before_filter :authenticate_user!
  # GET /forums
  # GET /forums.xml
  def index
    @forums = Forum.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @forums }
    end
  end

  # GET /forums/1
  # GET /forums/1.xml
  def show
    @forum = Forum.get(params[:id])

    marked_forum = MarkedForum.first_or_create(:forum_id => @forum.id, :user_id => current_user.id)
    marked_forum.last_read_at = Time.now
    marked_forum.save

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @forum }
    end
  end

end
