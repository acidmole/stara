module Standings
  extend Discordrb::Commands::CommandContainer

  Bot.message(with_text: 'standings') do |event|

  end

  Bot.message(with_text: '!sarjataulukot') do |event|
    event.respond 'En kerro'
  end

  Bot.message(with_text: 'sijoitukset') do |event|

  end

  Bot.message(with_text: 'ottelut') do |event|

  end
end

