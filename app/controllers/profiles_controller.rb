class ProfilesController < ApplicationController
 before_filter :authenticate_user!, :except => :show
  # GET /profiles/1
  # GET /profiles/1.xml
  def show
    @profile = Profile.get params[:id]
    @characters = @profile.characters
    if @profile.public_alts? || @profile == current_user.profile
      @characters += @profile.characters.first.alts unless @profile.characters.empty?
    end


    respond_to do |format|
      if (@profile.public? || current_user.andand.member?)
        format.html # show.html.erb
        format.xml  { render :xml => @profile }
      else
        format.html {redirect_to(root_url, :notice => "Sorry, this profile is private")}
        format.xml  { head :bad_request}
      end
    end
  end

  # GET /profiles/new
  # GET /profiles/new.xml
  def new
    if current_user.profile
      redirect_to(current_user.profile, :notice => 'Profile already exists') 
    else
      @profile = Profile.new
      @profile.user = current_user

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @profile }
      end
    end
  end

  # GET /profiles/1/edit
  def edit
    @profile = current_user.profile
  end

  # POST /profiles
  # POST /profiles.xml
  def create
    redirect_to(current_user.profile, :notice => 'Profile already exists') if current_user.profile
    @profile = Profile.new(params[:profile])
    @profile.user = current_user

    respond_to do |format|
      if @profile.save
        format.html { redirect_to(@profile, :notice => 'Profile was successfully created.') }
        format.xml  { render :xml => @profile, :status => :created, :location => @profile }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @profile.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /profiles/1
  # PUT /profiles/1.xml
  def update
    @profile = current_user.profile

    respond_to do |format|
      if @profile.update(params[:profile])
        format.html { redirect_to(profile_url, :notice => 'Profile was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @profile.errors, :status => :unprocessable_entity }
      end
    end
  end

end
