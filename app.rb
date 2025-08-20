require 'sinatra'
require "sinatra/reloader"
require "tilt/erubi"
require 'yaml'

before do
  @user_file = YAML.load_file("data/users.yaml")
  @users = []
  @user_file.each { |user| @users << user[0].to_s } 
end

# create redirect to home or a custom 404?

get "/" do

  erb :home
end

# helper methods
