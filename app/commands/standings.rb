module Standings
  extend Discordrb::Commands::CommandContainer

  Bot.message(start_with: '!standings') do |event|
    parameter = event.message.content.split(' ')[1].to_i
    if parameter == 0
      event.respond 'Minulla on sarjataulukot seuraaviin sarjoihin:'
      competitions = Competition.all
      competitions.each do |competition|
        event.respond "#{competition.name}, jonka id-numero on: #{competition.id}"
      end
      event.respond 'Käytä komentoa !sarjataulukot <sarjan id-numero> näyttääksesi sarjataulukon. Esim. !sarjataulukot 1'
    else
      competition = Competition.find_by(id: parameter)
      if !competition.nil?
        GamemappingApi.new.get_games_array_for(competition.id)
        standings = StandingsSorter.new.sort(competition.id)
        competition_name = "#{competition.name} sarjataulukko:"
        event.respond competition_name
        i = 1
        standings_output = ''
        standings.each do |standing|
          standings_output.concat("#{i}. #{standing.team.name} (#{standing.games} ottelua, #{standing.points} pistettä), ")
          i += 1
        end
        event.respond standings_output[0..-3]
      else
        event.respond 'Sarjaa ei löytynyt'
      end
    end
  end

  Bot.message(start_with: '!sarjataulukot') do |event, parameter|
    parameter = event.message.content.split(' ')[1].to_i
    if parameter == 0
      event.respond 'Minulla on sarjataulukot seuraaviin sarjoihin:'
      competitions = Competition.all
      competitions.each do |competition|
        event.respond "#{competition.name}, jonka id-numero on: #{competition.id}"
      end
      event.respond 'Käytä komentoa !sarjataulukot <sarjan id-numero> näyttääksesi sarjataulukon. Esim. !sarjataulukot 1'
    else
      competition = Competition.find_by(id: parameter)
      if !competition.nil?
        GamemappingApi.new.get_games_array_for(competition.id)
        standings = StandingsSorter.new.sort(competition.id)
        competition_name = "#{competition.name} sarjataulukko:"
        event.respond competition_name
        i = 1
        standings_output = ''
        standings.each do |standing|
          standings_output.concat("#{i}. #{standing.team.name} (#{standing.games} ottelua, #{standing.points} pistettä), ")
          i += 1
        end
        event.respond standings_output[0..-3]
      else
        event.respond 'Sarjaa ei löytynyt'
      end
    end
  end

  Bot.message(with_text: '!sijoitukset') do |event|

  end

  Bot.message(with_text: '!ottelut') do |event|

  end
end

