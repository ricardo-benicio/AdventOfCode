input = <<~INPUT
Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
INPUT

class Game
  attr_reader :id, :rounds

  def self.parse(line)
    first, *last = line.chomp.split(/[:;]/)
    id = first.split.last.to_i
    rounds = last.map do |str_round|
      str_round.split(',').map do |str_card|
        count, color = str_card.split
        [color.to_sym, count.to_i]
      end.to_h
    end
    new(id, rounds)
  end

  def initialize(id, rounds)
    @id = id
    @rounds = rounds
  end

  def max_cubes
    rounds.each_with_object({
                              red: 0,
                              blue: 0,
                              green: 0
                            }) do |round, counts|
      round.each do |color, count|
        counts[color] = count if count > counts[color]
      end
    end
  end

  def max_power
    max_cubes.values.inject(:*)
  end

  def possible?
    # Veja se há algum "movimento" inválido em alguma rodada
    max_cubes in {
      red: ..12,
      green: ..13,
      blue: ..14
    }

    # solution1
    #     rounds.each do |round|
    #       round.each do |color, count|
    #         if color == :red && count > 12
    #           return false
    #         elsif color == :blue && count > 14
    #           return false
    #         elsif color == :green && count > 13
    #           return false
    #         end
    #       end
    #     end
    #     true
  end
end

# data = input.each_line
data = File.readlines('lib/Day-2/input.txt')

r = data.map do |line|
  g = Game.parse(line)
  p line
  # p g.max_cubes
  p g.max_power
  #   if g.possible?
  #     g.id
  #   else
  #     0
  #   end
end

p r.sum
