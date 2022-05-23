require "test_helper"

class DrinksControllerTest < ActionDispatch::IntegrationTest
  def test_index
    get "/api/ping"
    assert(response, ["response doesn't exist"])
    assert_response :success
  end

  def test_get_drinks
    get "/api/drinks/"
    assert_response :success
  end

  def test_get_all_drinks
    get ("/api/drinks/?tags=gin,vodka,tequila,rum"), 
      params: 
        {"tags"=>"gin"}
        {"tags"=>"vodka"}
        {"tags"=>"tequila"}
        {"tags"=>"rum"}
    assert_response :success
  end

  def test_get_gin_drinks
    get ("/api/drinks/?tags=gin"), params: {"tags"=>"gin"}
    assert_response :success
  end

  def test_get_vodka_drinks
    get ("/api/drinks/?tags=vodka"), params: {"tags"=>"vodka"}
    assert_response :success
  end

  def test_get_history_drinks
    get ("/api/drinks/?tags=tequila"), params: {"tags"=>"tequila"}
    assert_response :success
  end

  def test_get_startups_drinks
    get ("/api/drinks/?tags=rum"), params: {"tags"=>"rum"}
    assert_response :success
  end

  def test_get_sorted_id_drinks
    get ("/api/drinks/?tags=rum&sortBy=idDrink"), params: {"sortBy"=>"idDrink"}
    assert_response :success
  end

  def test_get_sorted_likes_drinks
    get ("/api/drinks/?tags=vodka&sortBy=strDrink"), params: {"sortBy"=>"strDrink"}
    assert_response :success
  end

  def test_get_sorted_reads_drinks
    get ("/api/drinks/?tags=tequila&sortBy=idDrink"), params: {"sortBy"=>"idDrink"}
    assert_response :success
  end

  def test_get_sorted_popularity_drinks
    get ("/api/drinks/?tags=rum&sortBy=strDrink"), params: {"sortBy"=>"strDrink"}
    assert_response :success
  end

  def test_get_sorted_direction_asc_drinks
    get ("/api/drinks/?tags=vodka,rum&sortBy=idDrink&direction=asc"), params: {"direction"=>"asc"}
    assert_response :success
  end
  def test_get_sorted_direction_desc_drinks
    get ("/api/drinks/?tags=tequila,gin&sortBy=strDrink&direction=desc"), params: {"direction"=>"desc"}
    assert_response :success
  end
end
