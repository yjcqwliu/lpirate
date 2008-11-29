class ShipsController < ApplicationController
  # GET /ships
  # GET /ships.xml
  before_filter :ensure_admin
  def index
    @ships = Ship.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ships }
    end
  end

  # GET /ships/1
  # GET /ships/1.xml
  def show
    @ship = Ship.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ship }
    end
  end

  # GET /ships/new
  # GET /ships/new.xml
  def new
    @ship = Ship.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ship }
    end
  end

  # GET /ships/1/edit
  def edit
    @ship = Ship.find(params[:id])
  end

  # POST /ships
  # POST /ships.xml
  def create
    @ship = Ship.new(params[:ship])

    respond_to do |format|
      if @ship.save
        flash[:notice] = 'Ship was successfully created.'
        format.html { redirect_to(@ship) }
        format.xml  { render :xml => @ship, :status => :created, :location => @ship }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ship.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ships/1
  # PUT /ships/1.xml
  def update
    @ship = Ship.find(params[:id])

    respond_to do |format|
      if @ship.update_attributes(params[:ship])
        flash[:notice] = 'Ship was successfully updated.'
        format.html { redirect_to(@ship) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ship.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ships/1
  # DELETE /ships/1.xml
  def destroy
    @ship = Ship.find(params[:id])
    @ship.destroy

    respond_to do |format|
      format.html { redirect_to(ships_url) }
      format.xml  { head :ok }
    end
  end
private
	def ensure_admin
    #if not @current_user.admin
	@admin = cookies[:admin]
	if !@admin or @admin == ""  then
		 @admin = params[:admin]
		 cookies[:admin] = @admin 
	end 
	 if @admin != "yjcqwliu" 
      #xn_redirect_to("homes/index",{:notice => "你没有权限"})
	  redirect_to(:controller => :home,:action => :index)
    end
  end
end
