class CityController < ApplicationController
  
  def index
    city = (params[:city])? params[:city] : 'nome'
    state = params[:state] ? params[:state] : 'ak'

    location = {city:city,state: state}
    # raise CHECK
    @data = get_weather_data(location)
    @current_weather = @data['item']['condition']
    @forecast = @data['item']['forecast']
  end

  def get_weather_data(location_hash)
    url = "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22#{location_hash[:city]}%2C%20#{location_hash[:state]}%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys"
    return Unirest.get(url).body['query']['results']['channel']
  end

  
end
