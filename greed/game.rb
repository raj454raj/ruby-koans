require_relative 'helpers'
require_relative 'player'

class Game
    def initialize(n)
        @players = []
        n.times { |i| @players << Player.new(i + 1) }
        @round = 1
    end

    def print_stats
        puts Helpers::CYAN + "Round: " + @round.to_s + Helpers::RESET
        @round += 1
        @players.each do |player|
            puts "Player " + player.player_number.to_s + ": " + player.total_score.to_s
        end
    end

    def play
        flag = false
        while true do
            print_stats
            @players.each do |player|
                player.play_turn
                flag = true if player.total_score >= 3000
            end
            break if flag
        end
        winner = 0
        max_score = 0
        @players.each do |player|
            this_score = player.total_score
            if this_score >= 3000 and this_score > max_score
                winner = player.player_number
                max_score = this_score
            end
        end
        puts Helpers::PINK + "Winner is #{winner} with score #{max_score}" + Helpers::RESET
    end
end

if __FILE__ == $0
    print "Number of players: "
    players = gets.chomp.to_i
    game = Game.new(players)
    game.play
end