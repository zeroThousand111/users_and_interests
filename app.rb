require 'sinatra'
require "sinatra/reloader"
require "tilt/erubi"
require 'yaml'

before do
  @user_file = YAML.load_file("data/users.yaml")
  @users = @user_file.each_with_object([]) { |user, array| array << user[0].to_s }
end

# helper methods

## retrieve email of user
def fetch_email(name)
  @user_file[name.downcase.to_sym][:email]
end

## retrieve interests of user
def fetch_interests(name)
  @user_file[name.downcase.to_sym][:interests].join(", ")
end

## identify other users
def id_other_users(name)
  output = []
  @users.each { |user| output << user if user != name }
  output
end

## count total users and interests
def count_users
  @users.size
end

def count_interests
  total = 0

  @user_file.each do |user, hash|
    total += hash[:interests].size
  end

  total
end

# get methods

get "/" do
  erb :home
end

get "/:name" do
  @name = params[:name]

  if @users.include?(@name)
    @email = fetch_email(@name)
    @interests = fetch_interests(@name)
    @others = id_other_users(@name)
    erb :user
  else
    erb :user_not_found
  end
end
