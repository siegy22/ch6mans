module Discord
  class PlayerQueue
    REQUIRED_PLAYERS = 6

    attr_reader :users

    def initialize
      @users = Set.new
    end

    def <<(user)
      @users << user
      @on_player_joined.call(user) unless full?
      @on_ready.call(build_random_teams, @users.sample) if full?
    ensure
      @users = [] if full?
    end

    def delete(user)
      @users.delete(user)
    end

    def status
      "In queue right now: #{users.map(&:name).join(', ')}"
    end

    def on_ready(&block)
      @on_ready = block
    end

    def on_player_joined(&block)
      @on_player_joined = block
    end

    def stop
      @users = []
    end

    private
    def full?
      @users.size >= REQUIRED_PLAYERS
    end

    def build_random_teams
      shuffled = @users.shuffle
      {
        blue: shuffled[0..2],
        orange: shuffled[3..5]
      }
    end
  end
end
