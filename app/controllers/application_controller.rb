class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :load_menu_pages
  before_filter :set_timezone
  def load_menu_pages
    @menu_pages = Page.all(:in_menu => true, :order => [:position.asc])
  end
  def set_timezone
    Time.zone = current_user.profile.time_zone if current_user
  end

end
