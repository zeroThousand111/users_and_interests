require 'sinatra'
require "sinatra/reloader"
require "tilt/erubi"
require 'yaml'

before do
  @user_file = YAML.load_file("data/users.yaml")
  @users = @user_file.each_with_object([]) { |user, array| array << user[0].to_s } 
end

# helper methods

# retrieve email of user
def fetch_email(name)
  @user_file[name.downcase.to_sym][:email]
end

# retrieve interests of user
def fetch_interests(name)
  @user_file[name.downcase.to_sym][:interests].join(", ")
end

# get methods

# create redirect to home or a custom 404?

get "/" do
  erb :home
end

# can I programatically have just 1 get method for all users???
get "/jamy" do
  @name = "Jamy"
  @email = fetch_email(@name)
  @interests = fetch_interests(@name)
  erb :user
end

get "/nora" do
  @name = "Nora"
  @email = fetch_email(@name)
  @interests = fetch_interests(@name)
  erb :user
end

get "/hiroko" do
  @name = "Hiroko"
  @email = fetch_email(@name)
  @interests = fetch_interests(@name)
  erb :user
end

