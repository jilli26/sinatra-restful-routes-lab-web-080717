class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  #create new recipe
  get '/recipes/new' do
    erb :new
  end

  #index page
  get '/recipes' do
    @recipes = Recipe.all
    @recipe = Recipe.create(params)
    erb :index
  end

  #after creating a new recipe
  post '/recipes' do
    @recipe = Recipe.create(params)
    redirect to "/recipes/#{@recipe.id}"
  end

  #show page
  get '/recipes/:id' do
    @recipe = Recipe.find_by(id: params[:id])
    erb :show
  end

  #edit page - show the page
  get '/recipes/:id/edit' do
    @recipe = Recipe.find_by(id: params[:id])
    erb :edit
  end

  #update the page - patch
  patch '/recipes/:id' do
    @recipe = Recipe.find_by(id: params[:id])
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save

    redirect to "/recipes/#{@recipe.id}"
  end

  #delete 
  delete '/recipes/:id/delete' do
    @recipe = Recipe.find_by(id: params[:id])
    @recipe.delete

    redirect to "/recipes"
  end

end
