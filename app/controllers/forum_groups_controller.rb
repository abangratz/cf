class ForumGroupsController < ApplicationController
  before_filter :authenticate_user!
  # GET /forum_groups
  # GET /forum_groups.xml
  def index
    @forum_groups = current_user.forum_groups

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @forum_groups }
    end
  end

end
