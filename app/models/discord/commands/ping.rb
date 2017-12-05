module Discord
  module Commands
    class Ping < Base
      META = {
        description: 'Test if bot is alive.',
      }

      def execute(event, *_args)
        event << 'pong!'
      end
    end
  end
end
