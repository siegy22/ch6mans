module Discord
  COMMANDS = {
    queue: {
      min_args: 0,
      max_args: 0,
      description: 'Join the queue in the current channel, if there\'s no queue, it will start a new one.',
      usage: '!queue',
    },
    leave: {
      min_args: 0,
      max_args: 0,
      description: 'Leave the queue in the current channel.',
      usage: '!leave',
    },
    status: {
      min_args: 0,
      max_args: 0,
      description: 'Show the status of the queue in the current channel.',
      usage: '!status',
    },
    stop: {
      min_args: 0,
      max_args: 0,
      description: '[Admin only] Stops the channel\'s queue.',
      usage: '!stop',
    },
    remove: {
      min_args: 1,
      max_args: 1,
      description: '[Admin only] Remove user out of the channel\'s queue.',
      usage: '!remove [user]',
    }
  }.freeze

  ADMIN_ROLES = ENV.fetch('DISCORD_ADMIN_ROLES', '')
                   .split(',')
                   .map(&:to_i)
end
