module Discord
  module Commands
    class Queue < Base
      META = {
        description: 'Join the queue in the current channel, if there\'s no queue, it will start a new one.',
        usage: '!queue',
      }

      def execute(event, *_args)
        queue = PlayerQueue.find_or_create(event.channel)
        queue << event.user
        event.channel.send_embed('', queue.to_embed(event.user))
        queue.reset! if queue.full?
        nil
      end
    end
  end
end
