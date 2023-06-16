require "application_system_test_case"

class StandingsTest < ApplicationSystemTestCase
  setup do
    @standing = standings(:one)
  end

  test "visiting the index" do
    visit standings_url
    assert_selector "h1", text: "Standings"
  end

  test "should create standing" do
    visit standings_url
    click_on "New standing"

    fill_in "Competition", with: @standing.competition_id
    fill_in "Games", with: @standing.games
    fill_in "Points", with: @standing.points
    fill_in "Scored against", with: @standing.scored_against
    fill_in "Scored for", with: @standing.scored_for
    fill_in "Team", with: @standing.team_id
    fill_in "Wins", with: @standing.wins
    click_on "Create Standing"

    assert_text "Standing was successfully created"
    click_on "Back"
  end

  test "should update Standing" do
    visit standing_url(@standing)
    click_on "Edit this standing", match: :first

    fill_in "Competition", with: @standing.competition_id
    fill_in "Games", with: @standing.games
    fill_in "Points", with: @standing.points
    fill_in "Scored against", with: @standing.scored_against
    fill_in "Scored for", with: @standing.scored_for
    fill_in "Team", with: @standing.team_id
    fill_in "Wins", with: @standing.wins
    click_on "Update Standing"

    assert_text "Standing was successfully updated"
    click_on "Back"
  end

  test "should destroy Standing" do
    visit standing_url(@standing)
    click_on "Destroy this standing", match: :first

    assert_text "Standing was successfully destroyed"
  end
end
