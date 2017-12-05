module Discord
  class PlayerQueue
    REQUIRED_PLAYERS = 6

    @@queues = {}

    def self.find_or_create(channel)
      @@queues.fetch(channel) do
        queue = PlayerQueue.new
        @@queues[channel] = queue
        queue
      end
    end

    def initialize
      @users = []
    end

    def <<(user)
      @users << user
    end

    def delete(user)
      @users.delete(user)
    end

    def to_embed(joined_user = nil)
      if full?
        Discordrb::Webhooks::Embed.new(
          title: 'Lobby created!',
          color: EMBED_COLOR,
          fields: embed_fields,
          footer: Discordrb::Webhooks::EmbedFooter.new(
            text: 'Report the score in #report_score after the series is finished'
          ),
        )
      elsif joined_user
        Discordrb::Webhooks::Embed.new(
          title: "#{@users.count} players are in the queue",
          description: "#{joined_user.mention} has joined.",
          color: EMBED_COLOR,
        )
      else
        Discordrb::Webhooks::Embed.new(
          title: "#{@users.count} players are in the queue",
          description: @users.map(&:name).join(', '),
          color: EMBED_COLOR,
        )
      end
    end

    def stop!
      @users = []
    end
    alias_method :reset!, :stop!

    def active?
      @users.any?
    end

    def full?
      @users.size >= REQUIRED_PLAYERS
    end

    private
    def embed_fields
      shuffled = @users.shuffle
      [
        Discordrb::Webhooks::EmbedField.new(name: "Team blue",
                                            value: shuffled[0..2].map(&:mention).join(', '),
                                            inline: false),
        Discordrb::Webhooks::EmbedField.new(name: "Team orange",
                                            value: shuffled[3..5].map(&:mention).join(', '),
                                            inline: false),
        Discordrb::Webhooks::EmbedField.new(name: "Loby host",
                                            value: @users.sample.mention,
                                            inline: false),
      ]
    end
  end
end
