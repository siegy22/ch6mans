module Discord
  module Commands
    class Ping < Base
      META = {
        description: 'Test if bot is alive.',
      }

      def execute(event, *_args)
        File.open(Rails.root.join('app/assets/images/party.gif')) do |file|
          event.channel.send_file(file)
        end
      end
    end
  end
end
