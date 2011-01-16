class ItemAliasesController < ApplicationController
  # GET /item_aliases
  # GET /item_aliases.xml
  def index
    @item_aliases = ItemAlias.order('alias').paginate(:page => params[:page], :per_page => 25)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @item_aliases }
    end
  end

  # GET /item_aliases/1
  # GET /item_aliases/1.xml
  def show
    @item_alias = ItemAlias.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @item_alias }
    end
  end

  # GET /item_aliases/new
  # GET /item_aliases/new.xml
  def new
    @item_alias = ItemAlias.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @item_alias }
    end
  end

  # GET /item_aliases/1/edit
  def edit
    @item_alias = ItemAlias.find(params[:id])
  end

  # POST /item_aliases
  # POST /item_aliases.xml
  def create
    item = params[:item_alias].delete(:item)
    @item_alias = ItemAlias.new(params[:item_alias])
    @item_alias.item = Item.find_by_name(item)
    respond_to do |format|
      if @item_alias.save
        format.html { redirect_to(@item_alias, :notice => 'Item alias was successfully created.') }
        format.xml  { render :xml => @item_alias, :status => :created, :location => @item_alias }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @item_alias.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /item_aliases/1
  # PUT /item_aliases/1.xml
  def update
    item = params[:item_alias].delete(:item)
    @item_alias = ItemAlias.find(params[:id])
    @item_alias.item = Item.find_by_name(item)
    respond_to do |format|
      if @item_alias.update_attributes(params[:item_alias])
        format.html { redirect_to(@item_alias, :notice => 'Item alias was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @item_alias.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /item_aliases/1
  # DELETE /item_aliases/1.xml
  def destroy
    @item_alias = ItemAlias.find(params[:id])
    @item_alias.destroy

    respond_to do |format|
      format.html { redirect_to(item_aliases_url) }
      format.xml  { head :ok }
    end
  end
end
