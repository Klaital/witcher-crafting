class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]

  # GET /recipes
  # GET /recipes.json
  def index
    @recipes = Recipe.all
  end

  # GET /recipes/1
  # GET /recipes/1.json
  def show
  end

  # GET /recipes/new
  def new
    unless logged_in?
      flash.now[:warning] = 'Please log in to edit the database.'
      redirect_to login_path and return
    end

    @all_item_ids = []
    Item.find_each do |i|
      @all_item_ids.push([i.name, i.id])
    end
    @recipe = Recipe.new(:item_id => params[:produces])
  end

  # GET /recipes/1/edit
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

  # POST /recipes
  # POST /recipes.json
  def create
    unless logged_in?
      render :file => 'public/401', :status => :unauthorized, :layout => false and return
    end

    @recipe = Recipe.new(recipe_params)

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to @recipe, notice: 'Recipe was successfully created.' }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipes/1
  # PATCH/PUT /recipes/1.json
  def update
    unless logged_in?
      render :file => 'public/401', :status => :unauthorized, :layout => false and return
    end
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to @recipe, notice: 'Recipe was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1
  # DELETE /recipes/1.json
  def destroy
    unless logged_in?
      render :file => 'public/401', :status => :unauthorized, :layout => false and return
    end
    @recipe.destroy
    respond_to do |format|
      format.html { redirect_to recipes_url, notice: 'Recipe was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
      @item   = Item.find(@recipe.item_id)
      @ingredients = Ingredient.where(recipe_id: @recipe.id)
      @ingredients_cost = 0
      @ingredients.each do |ingredient|
        @ingredients_cost += ingredient.item.val.to_i
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recipe_params
      params.require(:recipe).permit(:item_id, :level, :artisan, :cost, :comments)
    end
end
