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
        event.channel.send_embed('', queue.to_embed)
      end
    end
  end
end
