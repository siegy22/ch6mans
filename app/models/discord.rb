module Discord
  ADMIN_ROLES = ENV.fetch('DISCORD_ADMIN_ROLES', '')
                   .split(',')
                   .map(&:to_i)
end
