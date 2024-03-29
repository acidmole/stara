require "test_helper"

class StandingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @standing = standings(:one)
  end

  test "should get index" do
    get standings_url
    assert_response :success
  end

  test "should get new" do
    get new_standing_url
    assert_response :success
  end

  test "should create standing" do
    assert_difference("Standing.count") do
      post standings_url, params: { standing: { competition_id: @standing.competition_id, games: @standing.games, points: @standing.points, scored_against: @standing.scored_against, scored_for: @standing.scored_for, team_id: @standing.team_id, wins: @standing.wins } }
    end

    assert_redirected_to standing_url(Standing.last)
  end

  test "should show standing" do
    get standing_url(@standing)
    assert_response :success
  end

  test "should get edit" do
    get edit_standing_url(@standing)
    assert_response :success
  end

  test "should update standing" do
    patch standing_url(@standing), params: { standing: { competition_id: @standing.competition_id, games: @standing.games, points: @standing.points, scored_against: @standing.scored_against, scored_for: @standing.scored_for, team_id: @standing.team_id, wins: @standing.wins } }
    assert_redirected_to standing_url(@standing)
  end

  test "should destroy standing" do
    assert_difference("Standing.count", -1) do
      delete standing_url(@standing)
    end

    assert_redirected_to standings_url
  end
end
