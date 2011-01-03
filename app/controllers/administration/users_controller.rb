class Administration::UsersController < ApplicationController
  before_filter :authenticate_admin!
  # GET /administration/users
  # GET /administration/users.xml
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /administration/users/1
  # GET /administration/users/1.xml
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /administration/users/new
  # GET /administration/users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /administration/users/1/edit
  def edit
    @user = User.find(params[:id])
    @roles = Role.all(:name.not => 'Guest')
  end

  # POST /administration/users
  # POST /administration/users.xml
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to(@user, :notice => 'User was successfully created.') }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /administration/users/1
  # PUT /administration/users/1.xml
  def update
    @user = User.find(params[:id])
    @user.roles = []
    @user.roles.save!
    links = RoleUser.all(:user_id => @user.id)
    logger.debug links.to_yaml
    params[:user].delete_if {|k, v| k =~ /^password/ && v == ""}
    params[:user][:roles].map! {|id| Role.get(id) } if params[:user][:roles]
    respond_to do |format|
      if true # @user.update_attributes(params[:user])
        format.html { redirect_to(administration_user_url(@user), :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /administration/users/1
  # DELETE /administration/users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
end
