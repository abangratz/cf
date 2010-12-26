class ForumGroupsController < ApplicationController
  # GET /forum_groups
  # GET /forum_groups.xml
  def index
    @forum_groups = ForumGroup.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @forum_groups }
    end
  end

end
