module Ping
  extend Discordrb::Commands::CommandContainer

  Bot.message(with_text: 'Ping!') do |event|
    event.respond 'Pong!'
  end
end

