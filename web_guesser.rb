require 'sinatra'
require 'sinatra/reloader'

SECRET_NUM = rand(101)

get '/' do
	guess = params["guess"].to_i
	message = check_guess(guess)
	bcolor = get_bcolor(message)
	erb :index, :locals => {:secret_num => SECRET_NUM, :message => message,
		:bcolor => bcolor}
end

def check_guess(guess)
	if SECRET_NUM - guess < -5
      	"Way Too High"
    elsif SECRET_NUM - guess > 5
    	"Way Too Low"
    elsif SECRET_NUM == guess
      	"You got it right!"
    elsif SECRET_NUM > guess
      	"Too Low"
    elsif SECRET_NUM < guess
      	"Too High" 
    end
end

def get_bcolor(message)
	if message == "Way Too High" || message == "Way Too Low"
		'red'
	elsif message == "Too Low" || message == "Too High"
		'lightcoral'
	else
		'green'
	end
end