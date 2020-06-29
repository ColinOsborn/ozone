class HomeController < ApplicationController
    require 'net/http'
    require 'json'

    def index
        api_key = Rails.application.credentials.API_KEY
        @url = "http://www.airnowapi.org/aq/observation/zipCode/current/?format=application/json&zipCode=81623&distance=100&API_KEY=#{api_key}"
        @uri = URI(@url)
        @response = Net::HTTP.get(@uri)
        @output = JSON.parse(@response)
        if @output.empty? || !@output
            @final_output = "An Error has occured, please check again later"
        else
            @final_output = @output[0]['AQI'] 
        end

        case @final_output
        when "An Error has occured, please check again later"
            @quality_color = "error"
        when 0..50 
            @quality_color = "good"
            @quality_description = "Air quality is satisfactory, and air pollution poses little or no risk."
        when 51..100
            @quality_color = "moderate"
            @quality_description = "Air quality is acceptable. However, there may be a risk for some people, particularly those who are unusually sensitive to air pollution."
        when 101..150
            @quality_color = "usg"
            @quality_description = "Members of sensitive groups may experience health effects. The general public is less likely to be affected."
        when 151..200
            @quality_color = "unhealthy"
            @quality_description = "Some members of the general public may experience health effects; members of sensitive groups may experience more serious health effects."
        when 201..300
            @quality_color = "very-unhealthy"
            @quality_description = "Health alert: The risk of health effects is increased for everyone."
        when 301..500
            @quality_color = "hazadous"
            @quality_description = "Health warning of emergency conditions: everyone is more likely to be affected."
        else
            @quality_color = "error"
        end
    end

    def zipcode
        @zip_query = params[:zipcode]
        # make sure to do some error handling to ensure this a string with proper format
        if params[:zipcode] == ""
            @zip_query = "Invalid zipcode entry"
        elsif params[:zipcode]
            #do api search
        end

        api_key = Rails.application.credentials.API_KEY
        @url = "http://www.airnowapi.org/aq/observation/zipCode/current/?format=application/json&zipCode=#{@zip_query}&distance=100&API_KEY=#{api_key}"
        @uri = URI(@url)
        @response = Net::HTTP.get(@uri)
        @output = JSON.parse(@response)
        if @output.empty? || !@output
            @final_output = "An Error has occured, please check again later"
        else
            @final_output = @output[0]['AQI'] 
        end

        case @final_output
        when "An Error has occured, please check again later"
            @quality_color = "error"
        when 0..50 
            @quality_color = "good"
            @quality_description = "Air quality is satisfactory, and air pollution poses little or no risk."
        when 51..100
            @quality_color = "moderate"
            @quality_description = "Air quality is acceptable. However, there may be a risk for some people, particularly those who are unusually sensitive to air pollution."
        when 101..150
            @quality_color = "usg"
            @quality_description = "Members of sensitive groups may experience health effects. The general public is less likely to be affected."
        when 151..200
            @quality_color = "unhealthy"
            @quality_description = "Some members of the general public may experience health effects; members of sensitive groups may experience more serious health effects."
        when 201..300
            @quality_color = "very-unhealthy"
            @quality_description = "Health alert: The risk of health effects is increased for everyone."
        when 301..500
            @quality_color = "hazadous"
            @quality_description = "Health warning of emergency conditions: everyone is more likely to be affected."
        else
            @quality_color = "error"
        end
    end

end