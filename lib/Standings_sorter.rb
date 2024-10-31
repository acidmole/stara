class StandingsSorter
  def sort(competition_id, teams_array = nil)
    if teams_array.nil?
      the_real_sorter(Standing.where(competition_id: competition_id))
    end
  end

  def the_real_sorter(standings)
    sorted_standings = standings.sort_by do |standing|
      [standing.points, standing.scored_against == 0 ? 0 : standing.scored_for / standing.scored_against]
    end
    sorted_standings.reverse
  end
end