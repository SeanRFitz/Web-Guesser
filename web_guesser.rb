require 'sinatra'
require 'sinatra/reloader'

s_num = rand(101)
get '/' do
	"The SECRET Number is #{s_num}"
end