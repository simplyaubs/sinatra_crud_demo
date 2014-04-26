require 'sinatra/base'

class Application < Sinatra::Application

  def initialize(app=nil)
    super(app)

    # initialize any other instance variables for you
    # application below this comment. One example would be repositories
    # to store things in a database.

  end

  get '/' do
    erb :index, locals: { list_of_cats: DB[:cats].to_a }
  end

  get '/cats/new' do
    erb :new
  end

  post '/cats' do
    p params
    # DB[:cats].insert(params[:cat])
    DB[:cats].insert(name: params[:name], color: params[:color], kittens: params[:kittens])
    redirect '/'
  end

  get '/cats/:id' do
    cat_id = params[:id]
    erb :show, locals: { single_cat: DB[:cats][id: cat_id] }
  end

  put '/cats/:id' do
    cat_id = params[:id]
    DB[:cats].where(id: cat_id).update(name: params[:name], color: params[:color], kittens: params[:kittens])
    redirect "/cats/#{cat_id}"
  end

  delete '/cats/:id' do
    cat_id = params[:id]
    DB[:cats].where(id: cat_id).delete
    redirect '/'
  end
end