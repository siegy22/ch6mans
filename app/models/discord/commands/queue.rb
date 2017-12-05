module Discord
  module Commands
    class Queue < Base
      META = {
        description: 'Join the queue in the current channel, if there\'s no queue, it will start a new one.',
        usage: '!queue',
      }

      def execute(event, *_args)
        queue = PlayerQueue.find_or_create(event.channel)
        queue.on_player_joined do |user|
          event << "#{user.name} joined the queue!"
        end
        queue.on_ready do |teams, host|
          event << "Lobby host: #{host.mention}"
          event << ''
          teams.each do |team, users|
            event << "**Team #{team}**:"
            users.each { |user| event << "  - #{user.mention}" }
          end
        end
        queue << event.user
      end
    end
  end
end
