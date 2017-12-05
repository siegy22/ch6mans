module Discord
  module Commands
    class Remove < Base
      include DiscordrbBotAware

      META = {
        min_args: 1,
        max_args: 1,
        description: '[Admin only] Remove user out of the channel\'s queue.',
        usage: '!remove [user]',
        required_roles: Discord::ADMIN_ROLES,
      }

      def execute(event, user)
        queue = PlayerQueue.find_or_create(event.channel)
        user = discordrb_bot.parse_mention(user)
        if user.present?
          queue.delete(user)
          event << "Removed #{user.mention} from the current queue."
        else
          event << 'You need to mention the desired user, like: `!remove @Aim#7679`'
        end
      end
    end
  end
end
