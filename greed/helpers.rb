module Helpers
    ALLOWED_DICES = 5
    RED = "\033[1;31m"
    ORANGE = "\033[1;33"
    PINK = "\033[1;35m"
    CYAN = "\033[1;36m"
    RESET = "\033[0m"

    def self.array_to_count(arr)
        count_hash = Hash.new(0)
        arr.each { |key| count_hash[key] += 1 }
        return count_hash
    end

    def self.compute_score(roll)
        count_hash = array_to_count(roll)
        result = scoring = 0
        count_hash.each do |key, val|
          # Triplet cases
          if val >= 3
            if key == 1
              result += 1000
            elsif key == 5
              result += 500
            else
              result += key * 100
            end
            scoring += 3
            val -= 3
          end

          # Residual 1s and 5s
          if key == 1
            result += val * 100
            scoring += val
          elsif key == 5
            result += val * 50
            scoring += val
          end
        end
        return [result, scoring]
    end

    def self.roll_single_dice
        rand(1..6)
    end

    def self.roll_dice(n)
        Array.new(n) { roll_single_dice }
    end
end