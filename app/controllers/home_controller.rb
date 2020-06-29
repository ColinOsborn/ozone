class HomeController < ApplicationController

    def index 
        require 'net/http'
        require 'json'
        # @url = 'http://www.airnowapi.org/aq/observation/zipCode/current/?format=application/json&zipCode=81611&distance=2&API_KEY=B13144EB-18EB-4067-8485-1473BF537575'
        @url = "http://www.airnowapi.org/aq/observation/zipCode/current/?format=application/json&zipCode=81623&distance=100&API_KEY=B13144EB-18EB-4067-8485-1473BF537575"
        @uri = URI(@url)
        @response = Net::HTTP.get(@uri)
        @output = JSON.parse(@response)
    end

end