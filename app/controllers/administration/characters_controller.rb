class Administration::CharactersController < AdministrationController
  before_filter :load_associations
  def load_associations
    @ranks = Rank.all
    @mains = Character.all(:rank => {:id.not => Character::ALT_RANK_IDS})
    @alts = Character.all(:rank => {:id => Character::ALT_RANK_IDS})
    @profiles = Profile.all
  end
  # GET /administration/characters
  # GET /administration/characters.xml
  def index
    @characters = Character.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @characters }
    end
  end

  # GET /administration/characters/1
  # GET /administration/characters/1.xml
  def show
    @character = Character.get(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @character }
    end
  end

  # GET /administration/characters/new
  # GET /administration/characters/new.xml
  def new
    @character = Character.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @character }
    end
  end

  # GET /administration/characters/1/edit
  def edit
    @character = Character.get(params[:id])
  end

  # POST /administration/characters
  # POST /administration/characters.xml
  def create
    @character = Character.new(params[:character])

    respond_to do |format|
      if @character.save
        format.html { redirect_to([:administration, @character], :notice => 'Character was successfully created.') }
        format.xml  { render :xml => @character, :status => :created, :location => @character }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @character.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /administration/characters/1
  # PUT /administration/characters/1.xml
  def update
    @character = Character.get(params[:id])
    params[:character] = params[:character].map { |x,y| [x, y.empty? ? nil : y ] }.to_hash

    respond_to do |format|
      if @character.update(params[:character])
        format.html { redirect_to([:administration, @character], :notice => 'Character was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @character.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /administration/characters/1
  # DELETE /administration/characters/1.xml
  def destroy
    @character = Character.get(params[:id])
    @character.destroy

    respond_to do |format|
      format.html { redirect_to(administration_characters_url) }
      format.xml  { head :ok }
    end
  end
end
