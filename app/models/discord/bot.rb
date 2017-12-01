# coding: utf-8
module Discord
  class Bot
    def initialize
      @queues = {}
      @bot = Discordrb::Commands::CommandBot.new(
        token: ENV.fetch('DISCORD_BOT_TOKEN'),
        prefix: '!'
      )
      Discord::COMMANDS.each do |command, arguments|
        @bot.command(command, arguments, &method(command))
      end
    end

    def run
      @bot.run
    end

    def queue(event)
      queue = @queues.fetch(event.channel, Discord::PlayerQueue.new)
      queue.on_player_joined do |user|
        event << "#{user.name} joined the queue!"
      end
      queue.on_ready do |teams, host|
        event << "Lobby host: #{host.mention}"
        event << ""
        teams.each do |team, users|
          event << "**Team #{team}**:"
          users.each { |user| event << "  - #{user.mention}" }
        end
      end
      queue << event.user
      @queues[event.channel] = queue
      nil
    end

    def status(event)
      queue = @queues[event.channel]
      if queue.present? && queue.users.any?
        queue.status
      else
        'There\'s no queue in the current channel, use `!queue` to create a new one.'
      end
    end

    def leave(event)
      queue = @queues[event.channel]
      event << "#{event.user.mention} left successfully." if queue.delete(event.user)
      @queues[event.channel] = queue
      nil
    end

    def stop(event)
      return unless admin_user?(event.user)

      queue = @queues[event.channel]
      if queue.present? && queue.users.any?
        queue.stop
        @queues[event.channel] = queue
        'Queue has been stopped.'
      else
        'Sorry, no queue found.'
      end
    end

    def remove(event, user)
      return unless admin_user?(event.user)

      queue = @queues[event.channel]
      user = @bot.parse_mention(user)
      if user.present?
        queue.delete(user)
        @queues[event.channel] = queue
        "Removed #{user.mention} from the current queue."
      else
        'You need to mention the desired user, like: `!remove @Aim#7679`'
      end
    end

    def ping(_event, *_args)
      'pong!'
    end

    private
    def admin_user?(user)
      user.roles.any? { |role| ADMIN_ROLES.include?(role.id) }
    end
  end
end
