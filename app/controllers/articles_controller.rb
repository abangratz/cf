class ArticlesController < ApplicationController
  # GET /articles
  # GET /articles.xml
  def index
    @title = "News"
    @articles = Article.paginate :page => params[:page], :order => :created_at.desc, :per_page => 5

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @articles }
    end
  end

  # GET /articles/1
  # GET /articles/1.xml
  def show
    @article = Article.first(:slug => params[:id])
    @title = @article.title.dup

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @article }
    end
  end

end
