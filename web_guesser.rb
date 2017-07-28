require 'sinatra'
require 'sinatra/reloader'

SECRET_NUM = rand(101)
@@remaining_guesses = 5


def check_guess(guess)
	if SECRET_NUM - guess < -5
      	"Way Too High"
    elsif SECRET_NUM - guess > 5
    	"Way Too Low"
    elsif SECRET_NUM == guess
      	"You guessed right! The Secret Number was #{SECRET_NUM}. Try again!"
    elsif SECRET_NUM > guess
      	"Too Low"
    elsif SECRET_NUM < guess
      	"Too High" 
    end
end

def get_bcolor(message)
	if message.match(/^Way/)
		'red'
	elsif message.match(/^Too/)
		'lightcoral'
	elsif message.match(/right\!/)
		'green'
	else
		'white'
	end
end

get '/' do
	cheat = params["cheat"]
	if params["guess"] == nil
		message = "Guess a number between 1 and 100."
	else
		guess = params["guess"].to_i
		@@remaining_guesses -= 1
		if guess == SECRET_NUM
			message = check_guess(guess)
			SECRET_NUM = rand(101)
			@@remaining_guesses = 5
		elsif @@remaining_guesses == 0
			message = "Game Over! The number was #{SECRET_NUM}. Try again!"
			@@remaining_guesses = 5
			SECRET_NUM = rand(101)
		else
			message = check_guess(guess)
		end
	end
	bcolor = get_bcolor(message)
	erb :index, :locals => {:secret_num => SECRET_NUM, :message => message,
		:bcolor => bcolor, :cheat => cheat}
end
