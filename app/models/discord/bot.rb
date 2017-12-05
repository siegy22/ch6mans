# coding: utf-8
module Discord
  class Bot
    include DiscordrbBotAware

    def initialize
      commands.each do |cmd|
        command = cmd.new
        discordrb_bot.command(command.name.to_sym,
                              command.meta,
                              &command.method(:execute))
      end
    end

    def run
      discordrb_bot.run
    end

    private
    def commands
      Dir["#{File.expand_path(__dir__)}/commands/*.rb"].inject([]) do |memo, path|
        cmd_class_name = File.basename(path, '.*').camelize
        # Ignore irrelevant files
        unless ['Base'].include?(cmd_class_name)
          memo << Discord.const_get("Commands::#{cmd_class_name}", false)
        end
        memo
      end
    end
  end
end
