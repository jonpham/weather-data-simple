class CityController < ApplicationController
  
  def index
    if @location == nil
      @location = {city:'nome',state: 'ak'}
    end
    @data = get_weather_data(@location)
    # data['location']['city']
    @forecast = @data['item']['forecast']
  end

  def create
    @location = {city: params[:input_city], state: params[:input_state]}
    @data = get_weather_data(@location)
    # data['location']['city']
    @forecast = @data['item']['forecast']
    render :index
  end

  def get_weather_data(location_hash)
    url = "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22#{location_hash[:city]}%2C%20#{location_hash[:state]}%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys"
    return Unirest.get(url).body['query']['results']['channel']
  end

  
end
