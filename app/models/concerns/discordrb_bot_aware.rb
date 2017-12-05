module DiscordrbBotAware
  extend ActiveSupport::Concern

  def discordrb_bot
    Rails.application.config.x.discordrb_bot
  end
end
