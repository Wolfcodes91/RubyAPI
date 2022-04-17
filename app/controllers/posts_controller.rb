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
    if !params[:tags]
      response = 
      {
        "error": "Tags parameter is required"
      }
      render json: response
      return
    end
    @category = params[:tags].split(",")
      jsonArr = []
      for cat in @category
        url = "https://api.hatchways.io/assessment/blog/posts?tag=#{cat}"
        response = RestClient.get(url)
        jsonArr.push(JSON.parse(response))
      end
      posts = jsonArr[0]['posts']
        x = 1
        while x < jsonArr.length
          posts = posts + jsonArr[x]['posts']
          x+=1
        end
      uniquePosts = posts.uniq
      data = {"posts": uniquePosts}
    if params[:sortBy] && !params[:direction]
      if params[:sortBy] === "id"
        sortedData = data.values[0].sort_by { |h | h["id"]}
      elsif params[:sortBy] === "reads"
        sortedData = data.values[0].sort_by { |h | h["reads"]}
      elsif params[:sortBy] === "likes"
        sortedData = data.values[0].sort_by { |h | h["likes"]}
      elsif params[:sortBy] === "popularity"
        sortedData = data.values[0].sort_by { |h | h["popularity"]}
      end
      data = {"posts": sortedData}
    elsif params[:direction]
      if params[:direction] === 'asc'
        if params[:sortBy] === "id"
          sortedData = data.values[0].sort_by { |h | h["id"]}
        elsif params[:sortBy] === "reads"
          sortedData = data.values[0].sort_by { |h | h["reads"]}
        elsif params[:sortBy] === "likes"
          sortedData = data.values[0].sort_by { |h | h["likes"]}
        elsif params[:sortBy] === "popularity"
          sortedData = data.values[0].sort_by { |h | h["popularity"]}
        end
        data = {"posts": sortedData}
      elsif params[:direction] === 'desc'
        if params[:sortBy] === "id"
          sortedData = data.values[0].sort_by { |h | h["id"]}.reverse()
        elsif params[:sortBy] === "reads"
          sortedData = data.values[0].sort_by { |h | h["reads"]}.reverse()
        elsif params[:sortBy] === "likes"
          sortedData = data.values[0].sort_by { |h | h["likes"]}.reverse()
        elsif params[:sortBy] === "popularity"
          sortedData = data.values[0].sort_by { |h | h["popularity"]}.reverse()
        end
        data = {"posts": sortedData}
      else
        data = 
        {
          "error": "sortBy parameter is invalid"
        }
      end
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
