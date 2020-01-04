
require 'sinatra/activerecord' 
require 'sinatra'
require "sinatra/flash"
require './models'



set :port, 3000


set :database, {adapter: "sqlite3", database: "./rumblr.sqlite3"}
enable :sessions



get '/' do 
    erb :home
end

get '/login' do
    erb :login
end

#fix this post not working

post '/login/' do
    @user = User.find_by(email: params[:email])
    given_password = params[:password]  
    if @user.password == given_password
        session[:user_id] = @user.id
        
    redirect '/profile'
    else
    end
end

get '/signup' do
    erb :signup
end

post '/signup' do
    @user = User.new(params[:user])
    if @user.valid?
        @user.save
        redirect '/profile'
    else
        flash[:error] = @user.errors.full_messages
        redirect '/signup'
    end
end

get '/profile' do
    redirect '/' unless session[:user_id]
    erb :profile
end
    
post '/logout' do
    session.clear
    redirect '/login'
end
