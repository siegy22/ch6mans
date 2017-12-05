module Discord
  ADMIN_ROLES = ENV.fetch('DISCORD_ADMIN_ROLES', '')
                   .split(',')
                   .map(&:to_i)
  EMBED_COLOR = ENV.fetch('DISCORD_EMBED_COLOR', '00EE00').freeze
end
