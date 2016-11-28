class IngredientsController < ApplicationController
  before_action :set_recipe
  before_action :set_ingredient, only: [:show, :edit, :update, :destroy]


  # GET /ingredients
  # GET /ingredients.json
  def index
    @ingredients = Ingredient.where(:recipe_id => @recipe.id)
    @sum_ingredient_val = 0
    @ingredients.find_each do |ingredient|
      @sum_ingredient_val += ingredient.item.val.to_i
    end
  end

  # GET /ingredients/1
  # GET /ingredients/1.json
  def show
  end

  # GET /ingredients/new
  def new
    unless logged_in?
      flash.now[:warning] = 'Please log in to edit the database.'
      redirect_to login_path and return
    end

    @all_item_ids = []
    Item.find_each do |i|
      @all_item_ids.push([i.name, i.id])
    end

    @ingredient = Ingredient.new
  end

  # GET /ingredients/1/edit
  def edit
    unless logged_in?
      flash.now[:warning] = 'Please log in to edit the database.'
      redirect_to login_path and return
    end

    @all_item_ids = []
    Item.find_each do |i|
      @all_item_ids.push([i.name, i.id])
    end
  end

  # POST /ingredients
  # POST /ingredients.json
  def create
    unless logged_in?
      render :file => 'public/401', :status => :unauthorized, :layout => false and return
    end

    @ingredient = Ingredient.new(ingredient_params)

    respond_to do |format|
      if @ingredient.save
        format.html { redirect_to [@recipe, @ingredient], notice: 'Ingredient was successfully created.' }
        format.json { render :show, status: :created, location: @ingredient }
      else
        flash.now[:error] = 'Unable to save ingredient'
        format.html { redirect_to new_recipe_ingredient_path }
        format.json { render json: @ingredient.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ingredients/1
  # PATCH/PUT /ingredients/1.json
  def update
    unless logged_in?
      render :file => 'public/401', :status => :unauthorized, :layout => false and return
    end

    respond_to do |format|
      if @ingredient.update(ingredient_params)
        format.html { redirect_to [@recipe, @ingredient], notice: 'Ingredient was successfully updated.' }
        format.json { render :show, status: :ok, location: [@recipe, @ingredient] }
      else
        format.html { render :edit }
        format.json { render json: @ingredient.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ingredients/1
  # DELETE /ingredients/1.json
  def destroy
    unless logged_in?
      render :file => 'public/401', :status => :unauthorized, :layout => false and return
    end

    @ingredient.destroy
    respond_to do |format|
      format.html { redirect_to recipe_ingredients_url(@recipe), notice: 'Ingredient was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_recipe
      @recipe = Recipe.find(params[:recipe_id])
      @item   = Item.find(@recipe.item_id)
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_ingredient
      @ingredient = Ingredient.find(params[:id])
      @ingredient_item = Item.find(@ingredient.item_id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ingredient_params
      params.require(:ingredient).permit(:item_id, :qty, :recipe_id).merge({recipe_id: @recipe.id})
    end
end
