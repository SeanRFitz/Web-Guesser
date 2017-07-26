require 'sinatra'
require 'sinatra/reloader'

s_num = rand(101)
get '/' do
	erb :index, :locals => {:s_num => s_num}
end