module Discord
  module Commands
    class Leave < Base
      META = {
        description: 'Leave the queue in the current channel.',
        usage: '!leave',
      }

      def execute(event, *_args)
        queue = PlayerQueue.find_or_create(event.channel)
        event << "#{event.user.mention} left successfully." if queue.delete(event.user)
      end
    end
  end
end
