class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :load_menu_pages
  def load_menu_pages
    @menu_pages = Page.all(:in_menu => true, :order => [:position.asc])
  end
end
