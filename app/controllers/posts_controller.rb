class PostsController < ApplicationController
  require 'rest-client'
  require 'json'
  before_action :set_post, only: %i[ show update destroy ]

  def index
    response = 
    {
      "success":true
    }
    render json: response
  end
  
  def get_posts
    if params[:tags]
    @category = params[:tags].split(",")
      jsonArr = []
      i = 0
      for cat in @category
        url = "https://api.hatchways.io/assessment/blog/posts?tag=#{cat}"
        puts cat, i
        response = RestClient.get(url)
        jsonArr.push(JSON.parse(response))
        i+=1
      end
      puts jsonArr.length
      posts = jsonArr[0]['posts']
      if jsonArr.length > 1
        # x = 1
        # while x < jsonArr.length
        posts = jsonArr[0]['posts'] + jsonArr[1]['posts']
        #   posts = posts + jsonArr[x]['posts']
        #   x+=1
        # end
      end
      puts posts
      uniquePosts = posts.uniq
      data = {"posts": uniquePosts}
    # elsif params[:direction]
    #   @direction = params[:direction]
    #   @sortBy = params[:sortBy]
    #   @category = params[:tags]
    #   url = "https://api.hatchways.io/assessment/blog/posts?tag=#{@category}&sortBy=#{@sortBy}&direction=#{@direction}"
    #   puts url, "if"
    #   data = RestClient.get(url)
    # elsif params[:sortBy]
    #   @sortBy = params[:sortBy]
    #   @category = params[:tags]
    #   url = "https://api.hatchways.io/assessment/blog/posts?tag=#{@category}&sortBy=#{@sortBy}"
    #   puts url, "elsif1"
    #   data = RestClient.get(url)
    else
      url = "https://api.hatchways.io/assessment/blog/posts?tag=none"
      data = RestClient.get(url)
    end
    render json: data
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
