module Discord
  module Commands
    class Stop < Base
      META = {
        description: '[Admin only] Stops the channel\'s queue.',
        usage: '!stop',
        required_roles: Discord::ADMIN_ROLES,
      }

      def execute(event, *_args)
        queue = PlayerQueue.find_or_create(event.channel)
        if queue.active?
          queue.stop!
          event << 'Queue has been stopped.'
        else
          event << 'Sorry, no queue found.'
        end
      end
    end
  end
end
