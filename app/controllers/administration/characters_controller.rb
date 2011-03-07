class Administration::CharactersController < AdministrationController
  # GET /administration/characters
  # GET /administration/characters.xml
  def index
    @characters = Character.all
    @ranks = Rank.all
    @alts = Character.all(:rank => {:id => Character::ALT_RANK_IDS})

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @characters }
    end
  end

  # GET /administration/characters/1
  # GET /administration/characters/1.xml
  def show
    @character = Character.get(params[:id])
    @mains = 

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
    @ranks = Rank.all
    @mains = Character.all(:rank => {:id.not => Character::ALT_RANK_IDS})
    @alts = Character.all(:rank => {:id => Character::ALT_RANK_IDS})
    @profiles = Profile.all.select { |x| x.characters.empty? }
  end

  # POST /administration/characters
  # POST /administration/characters.xml
  def create
    @character = Character.new(params[:administration_character])

    respond_to do |format|
      if @character.save
        format.html { redirect_to(@character, :notice => 'Character was successfully created.') }
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
    @character = Character.find(params[:id])

    respond_to do |format|
      if @character.update_attributes(params[:administration_character])
        format.html { redirect_to(@character, :notice => 'Character was successfully updated.') }
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
    @character = Character.find(params[:id])
    @character.destroy

    respond_to do |format|
      format.html { redirect_to(administration_characters_url) }
      format.xml  { head :ok }
    end
  end
end
