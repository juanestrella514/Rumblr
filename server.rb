
require 'sinatra/activerecord' 
require 'sinatra'
require "sinatra/flash"
require './models'



set :port, 3000


set :database, {adapter: 'postgresql', database: 'rumblr', username: 'postgres', password: ENV['POSTGRES_PW']}

enable :sessions



get '/' do 
    erb :home
end

get '/signup' do
    erb :signup
end

post '/signup' do
    @user = User.new(params[:user])
    if @user.valid?
        @user.save
        session[:user_id] = @user.id
        session[:first_name] = @user.firstname
        redirect '/profile'
    else
        flash[:error] = @user.errors.full_messages
        redirect '/signup'
    end
end

get '/login' do
    erb :login
end


post '/login' do
    @user = User.find_by(email: params["email"])
    given_password = params[:password]  
    if @user.password == given_password
        session[:user_id] = @user.id
        session[:first_name] = @user.firstname  
        redirect '/profile'
    else
    end
end



get '/profile' do  
    @user = User.find_by(id: session[:user_id])
    erb :profile, :layout => :user_layout
    # rescue ActiveRecord::RecordNotFound
    #     puts "ERROR 404"
    #     erb :profile
end

post '/profile' do
    @article = Article.new(title: params["title"], content: params["content"], user_id: session[:user_id])
    if @article.valid?
        @article.save
        redirect '/profile'
    end
end 

    
get '/logout' do
    session[:user_id] = nil
    redirect '/login'
end


not_found do
    '<img src="https://i.gifer.com/5Oe.gif" height="100%" width="100%">'
end