require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  def test_index
    get "/api/ping"
    assert(response, ["response doesn't exist"])
    assert_response :success
  end

  def test_get_posts
    get "/api/posts/"
    assert_response :success
  end

  def test_get_all_posts
    get ("/api/posts/?tags=science,tech,history,startups,health,culture,design,politics"), 
      params: 
        {"tags"=>"science"}
        {"tags"=>"tech"}
        {"tags"=>"history"}
        {"tags"=>"startups"}
        {"tags"=>"health"}
        {"tags"=> "culture"}
        {"tags"=>"design"}
        {"tags"=>"politics"}
    assert_response :success
  end

  def test_get_science_posts
    get ("/api/posts/?tags=science"), params: {"tags"=>"science"}
    assert_response :success
  end

  def test_get_tech_posts
    get ("/api/posts/?tags=tech"), params: {"tags"=>"tech"}
    assert_response :success
  end

  def test_get_history_posts
    get ("/api/posts/?tags=history"), params: {"tags"=>"history"}
    assert_response :success
  end

  def test_get_startups_posts
    get ("/api/posts/?tags=startups"), params: {"tags"=>"startups"}
    assert_response :success
  end

  def test_get_health_posts
    get ("/api/posts/?tags=health"), params: {"tags"=>"health"}
    assert_response :success
  end

  def test_get_culture_posts
    get ("/api/posts/?tags=culture"), params: {"tags"=>"culture"}
    assert_response :success
  end

  def test_get_design_posts
    get ("/api/posts/?tags=design"), params: {"tags"=>"design"}
    assert_response :success
  end

  def test_get_politics_posts
    get ("/api/posts/?tags=politics"), params: {"tags"=>"politics"}
    assert_response :success
  end

  def test_get_sorted_id_posts
    get ("/api/posts/?tags=politics&sortBy=id"), params: {"sortBy"=>"id"}
    assert_response :success
  end

  def test_get_sorted_likes_posts
    get ("/api/posts/?tags=science&sortBy=likes"), params: {"sortBy"=>"likes"}
    assert_response :success
  end

  def test_get_sorted_reads_posts
    get ("/api/posts/?tags=health&sortBy=reads"), params: {"sortBy"=>"reads"}
    assert_response :success
  end

  def test_get_sorted_popularity_posts
    get ("/api/posts/?tags=startups&sortBy=popularity"), params: {"sortBy"=>"popularity"}
    assert_response :success
  end

  def test_get_sorted_direction_asc_posts
    get ("/api/posts/?tags=design&sortBy=popularity&direction=asc"), params: {"direction"=>"asc"}
    assert_response :success
  end
  def test_get_sorted_direction_desc_posts
    get ("/api/posts/?tags=culture&sortBy=reads&direction=desc"), params: {"direction"=>"desc"}
    assert_response :success
  end
end
