
require 'sinatra/activerecord' 
require 'sinatra'
require "sinatra/flash"
require './models'



set :port, 3000


set :database, {adapter: 'postgresql', database: 'rumblr', username: 'postgres', password: ENV['POSTGRES_PW']}

enable :sessions

# set :show_exceptions, :after_handler



get '/' do 
    erb :home
end

get '/signup' do
    erb :signup
end

post '/signup' do
    @user = User.new(params[:user])
    # if @user.valid?
    #     @user.save
    #     redirect '/profile'
    # else
    #     flash[:error] = @user.errors.full_messages
    #     redirect '/signup'
    # end
    pp @user

end

get '/login' do
    erb :login
end

#fix this post not working

post '/login' do
    @user = User.find_by(email: params[:email])
    given_password == params[:password]  
    if @user.password == given_password
        session[:user_firstname] = @user.firstname   
        redirect '/profile'

    else
    end
end



# get '/profile' do
#     redirect '/' unless session[:user_id]
#     erb :profile
# end

get '/profile/:email' do  
    @user = User.find(params[:email])
    erb :profile
    rescue ActiveRecord::RecordNotFound
        puts "ERROR 404"
        erb:profile
end

# get '/profile/:id' do  
#     @user = User.find(params[:id])
#     # @dogs = @user.dogs
#     # raise StandardError.new('This user has no dogs')
#     erb :profile   
# end
    
post '/logout' do
    session.clear
    redirect '/login'
end


not_found do
    '<img src="https://i.gifer.com/5Oe.gif" height="100%" width="100%">'
end

