require 'sinatra'
require 'json'
require "sinatra/json"
require "rest-client"

post '/paint', provides: 'json' do
  body = JSON.parse request.body.read
  validation_result = validate(body)
  if validation_result.nil?
    color = pick_color(body["random_color"])
    send_word(body['word'], color, body['channel'])
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
  elsif (! input["channel"] || input["channel"] == "")
    "no streaming without channel, we wouldn't know where to stream"
  else
    nil
  end
end

# it appears that there is no better way to validate this in ruby, short of declaring Boolean classes
# http://stackoverflow.com/questions/3028243/check-if-ruby-object-is-a-boolean
def is_bool input
  !!input == input
end

def send_word(word, color, channel)
  word_painter_url = "#{ENV['SOCKET_CALLER_URL']}/do-stream"
  RestClient.post word_painter_url, { 'word' => word, 'color' => color, 'channel' => channel }.to_json, :content_type => :json, :accept => :json
end