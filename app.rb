require "sinatra"
require "sinatra/reloader"
require "http"
require "json"

get("/") do
  list_of_curriencies_api_url = "https://api.exchangerate.host/list?access_key=#{ENV["EXCHANGE_RATE_KEY"]}"
  list_of_curriencies_raw_response = HTTP.get(list_of_curriencies_api_url)
  @list_of_curriencies_json = JSON.parse(list_of_curriencies_raw_response).fetch("currencies")
  erb(:homepage)
end

get("/:currency_to_convert")do
  list_of_curriencies_api_url = "https://api.exchangerate.host/list?access_key=#{ENV["EXCHANGE_RATE_KEY"]}"
  list_of_curriencies_raw_response = HTTP.get(list_of_curriencies_api_url)
  @list_of_curriencies_json = JSON.parse(list_of_curriencies_raw_response).fetch("currencies")

  @currency_to_convert = params.fetch("currency_to_convert")
  erb(:convert_currency)
end

get("/:currency_to_convert/:currency_to_convert_to")do
  @currency_to_convert = params.fetch("currency_to_convert")
  @currency_to_convert_to = params.fetch("currency_to_convert_to")

  exchange_rate_raw_response = HTTP.get("https://api.exchangerate.host/convert?access_key=#{ENV["EXCHANGE_RATE_KEY"]}&from=#{@currency_to_convert}&to=#{@currency_to_convert_to}&amount=1")
  @exchange_rate = JSON.parse(exchange_rate_raw_response).fetch("result")

  erb(:conversion)
end
