class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # GET /items
  # GET /items.json
  def index
    @items = Item.all
  end

  # GET /items/1
  # GET /items/1.json
  def show
  end

  # GET /items/new
  def new
    unless logged_in?
      flash.now[:warning] = 'Please log in to edit the database.'
      redirect_to login_path and return
    end

    # Set default values
    @item = Item.new
    @item.weight = 0.0
    @item.craft_type = 'component'
  end

  # GET /items/1/edit
  def edit
    unless logged_in?
      flash.now[:warning] = 'Please log in to edit the database.'
      redirect_to login_path and return
    end
  end

  # POST /items
  # POST /items.json
  def create
    unless logged_in?
      render :file => 'public/401', :status => :unauthorized, :layout => false and return
    end

    @item = Item.new(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: "#{@item.name} was successfully created." }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    unless logged_in?
      render :file => 'public/401', :status => :unauthorized, :layout => false and return
    end
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: "#{@item.name} was successfully created." }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    unless logged_in?
      render :file => 'public/401', :status => :unauthorized, :layout => false and return
    end
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
      @recipes = Recipe.where(:item_id => @item.id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:name, :slot, :tier, :craft_type, :armor, :damage_min, :damage_max,
                                   :val, :enhancement_slots, :other_effects, :comments, :armor_type,
                                   :weight, :level_requirement, :thumbnail_url, :thumbnail_size, :wiki_url)
      # params.fetch(:item, {})
    end
end
