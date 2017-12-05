Rails.application.config.x.discordrb_bot = Discordrb::Commands::CommandBot.new(
  token: ENV.fetch('DISCORD_BOT_TOKEN'),
  prefix: '!'
)
