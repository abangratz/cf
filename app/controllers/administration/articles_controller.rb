class Administration::ArticlesController < AdministrationController

  before_filter :authenticate_admin!
  # GET /administration/articles
  # GET /administration/articles.xml
  def index
    @articles = Article.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @articles }
    end
  end

  # GET /administration/articles/1
  # GET /administration/articles/1.xml
  def show
    @article = Article.first(:slug => params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @article }
    end
  end

  # GET /administration/articles/new
  # GET /administration/articles/new.xml
  def new
    @article = current_admin.articles.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @article }
    end
  end

  # GET /administration/articles/1/edit
  def edit
    @article = Article.first(:slug => params[:id])
  end

  # POST /administration/articles
  # POST /administration/articles.xml
  def create
    @article = Article.new(params[:article])

    respond_to do |format|
      if @article.save
        format.html { redirect_to(administration_article_path(@article), :notice => 'Article was successfully created.') }
        format.xml  { render :xml => @article, :status => :created, :location => @article }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /administration/articles/1
  # PUT /administration/articles/1.xml
  def update
    @article = Article.first(:slug => params[:id])

    respond_to do |format|
      if @article.update(params[:article])
        format.html { redirect_to(administration_article_path(@article), :notice => 'Article was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /administration/articles/1
  # DELETE /administration/articles/1.xml
  def destroy
    @article = Article.first(:slug => params[:id])
    @article.destroy

    respond_to do |format|
      format.html { redirect_to(administration_articles_url) }
      format.xml  { head :ok }
    end
  end
end
