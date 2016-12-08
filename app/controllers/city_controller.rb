class CityController < ApplicationController
  
  def index
    city = (params[:city])? params[:city] : 'nome'
    state = params[:state] ? params[:state] : 'ak'
    woeid = params[:woeid] ? params[:woeid] : '2487956'
    location = {city:city,state: state}
    # raise CHECK
    @data = get_weather_data(woeid)
    # @current_weather = @data['item']['condition']
    # @forecast = @data['item']['forecast']
  end

  def get_weather_data(woeid)
    response = Weather.lookup(woeid, Weather::Units::FAHRENHEIT)
    return reponse
  end

  
end
