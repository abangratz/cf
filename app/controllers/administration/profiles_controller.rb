class Administration::ProfilesController < AdministrationController
  # GET /administration/profiles
  # GET /administration/profiles.xml
  def index
    @administration_profileses = Administration::Profile.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @administration_profileses }
    end
  end

  # GET /administration/profiles/1
  # GET /administration/profiles/1.xml
  def show
    @administration_profile = Administration::Profile.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @administration_profile }
    end
  end

  # GET /administration/profiles/new
  # GET /administration/profiles/new.xml
  def new
    @administration_profile = Administration::Profile.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @administration_profile }
    end
  end

  # GET /administration/profiles/1/edit
  def edit
    @administration_profile = Administration::Profile.find(params[:id])
  end

  # POST /administration/profiles
  # POST /administration/profiles.xml
  def create
    @administration_profile = Administration::Profile.new(params[:administration_profile])

    respond_to do |format|
      if @administration_profile.save
        format.html { redirect_to(@administration_profile, :notice => 'Profile was successfully created.') }
        format.xml  { render :xml => @administration_profile, :status => :created, :location => @administration_profile }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @administration_profile.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /administration/profiles/1
  # PUT /administration/profiles/1.xml
  def update
    @administration_profile = Administration::Profile.find(params[:id])

    respond_to do |format|
      if @administration_profile.update_attributes(params[:administration_profile])
        format.html { redirect_to(@administration_profile, :notice => 'Profile was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @administration_profile.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /administration/profiles/1
  # DELETE /administration/profiles/1.xml
  def destroy
    @administration_profile = Administration::Profile.find(params[:id])
    @administration_profile.destroy

    respond_to do |format|
      format.html { redirect_to(administration_profileses_url) }
      format.xml  { head :ok }
    end
  end
end
