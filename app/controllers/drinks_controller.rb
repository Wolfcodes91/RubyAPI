class DrinksController < ApplicationController
  require 'rest-client'
  require 'json'
  require 'async'
  before_action :set_post, only: %i[ show update destroy ]

  def index
    response = 
    {
      "success":true
    }
    return render json: response
  end

  def tag_error
    message = 
      {
        "error": "Tags parameter is required"
      }
      return render json: message
  end

  def sort_by_error 
    message = 
      {
        "error": "sortBy parameter is invalid"
      }
    return render json: message  
  end

  def sort_by(sortParam, data, directionParam)
    sortedData = data.values[0].sort_by { |h | h[sortParam]}
    if directionParam === 'desc'
      sortedData = sortedData.reverse()
    end
    data = {"drinks": sortedData}
    return data
  end

  def handle_incoming_params(drink, jsonArr)
    for drink in @drink  
      Async do |task|
        task.async do 
          url = "www.thecocktaildb.com/api/json/v1/1/filter.php?i=#{drink}"
          Rails.cache.fetch(response = RestClient.get(url), expires_in: 12.hours)
          jsonArr.push(JSON.parse(response))
        end
      end
    end
  end

  def get_unique_drinks(drink)
    jsonArr = []
      handle_incoming_params(@drink, jsonArr)
      drinks = jsonArr[0]['drinks']
        x = 1
        while x < jsonArr.length
          drinks = drinks + jsonArr[x]['drinks']
          x+=1
        end
      uniqueDrinks = drinks.uniq {|d| d['idDrink'] } 
  end

  def get_drinks
    if !params[:tags]
      return tag_error() 
    end

    @drink = params[:tags].split(",")
    data = {"drinks": get_unique_drinks(@drink)}
    if !params[:sortBy]
      return render json: data
    end

    direction = params[:direction] ? params[:direction] : 'asc'
    validSortParams = ['strDrink', 'idDrink']
    validDirectionParams = ['asc', 'desc']
    if !validSortParams.include? params[:sortBy] or !validDirectionParams.include? direction
      return sort_by_error()
    end

    sortParam = params[:sortBy]
    data = sort_by(sortParam, data, direction)
    return render json: data
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:tags)
    end
end
