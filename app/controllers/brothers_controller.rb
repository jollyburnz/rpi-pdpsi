  class BrothersController < ApplicationController
    before_filter :login_required, :only => [:new, :create, :edit, :update, :destroy]
    
  # GET /brothers
  # GET /brothers.xml
  def index
    @brothers = Brother.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @brothers }
    end
  end

  # GET /brothers/1
  # GET /brothers/1.xml
  def show
    @brothers = Brother.all
    @brother = Brother.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @brother }
    end
  end

  # GET /brothers/new
  # GET /brothers/new.xml
  def new
    @brother = Brother.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @brother }
    end
  end

  # GET /brothers/1/edit
  def edit
    @brother = Brother.find(params[:id])
  end

  # POST /brothers
  # POST /brothers.xml
  def create
    @brother = Brother.new(params[:brother])

    respond_to do |format|
      if @brother.save
        flash[:notice] = 'Brother was successfully created.'
        format.html { render :back }
        format.xml  { render :xml => @brother, :status => :created, :location => @brother }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @brother.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /brothers/1
  # PUT /brothers/1.xml
  def update
    @brother = Brother.find(params[:id])

    respond_to do |format|
      if @brother.update_attributes(params[:brother])
        flash[:notice] = 'Brother was successfully updated.'
        format.html { redirect_to roster_show_path(@brother) }
        format.xml  { head :ok }
      else
        #debugger
        format.html { render :action => "edit" }
        format.xml  { render :xml => @brother.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /brothers/1
  # DELETE /brothers/1.xml
  def destroy
    @brother = Brother.find(params[:id])
    @brother.destroy

    respond_to do |format|
      format.html { redirect_to(brothers_url) }
      format.xml  { head :ok }
    end
  end
end
