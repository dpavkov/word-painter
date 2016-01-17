require 'sinatra'
require 'json'
require "sinatra/json"

post '/paint', provides: 'json' do
  body = JSON.parse request.body.read
  validation_result = validate(body)
  if validation_result.nil?
    color = pick_color(body["random_color"])
    json chosen: color
  else
    status 400
    json error: validation_result
  end
end

def pick_color is_random
  if is_random
    ["black", "green", "red"].sample
  else
    "black"
  end
end

def validate input
  if (! input["word"] || input["word"] == "")
    "no streaming without the word"
  elsif input["random_color"].nil?
    "no streaming without random color"
  elsif ! is_bool(input["random_color"])
    "color is random or it isn't no other option"
  else
    nil
  end
end

# it appears that there is no better way to validate this in ruby, short of declaring Boolean classes
# http://stackoverflow.com/questions/3028243/check-if-ruby-object-is-a-boolean
def is_bool input
  !!input == input
end