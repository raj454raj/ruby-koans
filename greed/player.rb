require_relative 'helpers'

class Player
    attr_reader :player_number, :total_score

    def initialize(player_number)
        @total_score = 0
        @player_number = player_number
        @incrementable_total_score = false
    end

    def play_turn
        puts "\n"
        puts Helpers::RED + "Player #{@player_number} turn" + Helpers::RESET
        allowed_dices = Helpers::ALLOWED_DICES
        turn_score = 0
        while true
            puts "Do you want to play more ? - Yes (Yy) / No (Nn)"
            decision = gets.chomp.downcase
            break if decision == "n"

            current_roll = Helpers::roll_dice(allowed_dices)
            puts "Current Dice values: " + current_roll.join(", ")
            roll_score, scoring = Helpers::compute_score(current_roll)
            turn_score += roll_score
            puts "Turn Score: " + turn_score.to_s
            @incrementable_total_score = true if turn_score >= 300
            if scoring == allowed_dices
                allowed_dices = Helpers::ALLOWED_DICES
            elsif scoring != 0
                allowed_dices -= scoring
            else
                turn_score = 0
                break
            end
        end
        @total_score += turn_score if @incrementable_total_score
        puts "*************************************************************"
    end
end