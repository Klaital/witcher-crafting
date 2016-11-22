json.extract! ingredient, :id, :item_id, :qty, :recipe_id, :created_at, :updated_at
json.url ingredient_url(ingredient, format: :json)