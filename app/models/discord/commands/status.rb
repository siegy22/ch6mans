module Discord
  module Commands
    class Status < Base
      META = {
        min_args: 0,
        max_args: 0,
        description: 'Show the status of the queue in the current channel.',
        usage: '!status',
      }

      def execute(event, *_args)
        queue = PlayerQueue.find_or_create(event.channel)
        if queue.active?
          event << queue.status
        else
          event << 'There\'s no queue in the current channel, use `!queue` to create a new one.'
        end
      end
    end
  end
end
