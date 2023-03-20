require 'pry-byebug'
class Tournament
  class << self
    def tally(tournament)
      ranking = {}
      add_teams(ranking, tournament)
      add_points(ranking, tournament)
      format(ranking)
    end

    private

    def add_teams(ranking, tournament)
      matches = tournament.split("\n")
      matches.each do |match|
        team1, team2, result = match.split(';')
        add_team(team1, ranking) unless ranking.key?(team1)
        add_team(team2, ranking) unless ranking.key?(team2)
      end
    end

    def add_points(ranking, tournament)
      matches = tournament.split("\n")
      matches.each do |match|
        team1, team2, result = match.split(';')
        count_match(team1, ranking, result)
        result = swap(result)
        count_match(team2, ranking, result)
      end
    end

    def swap(result)
      return 'win' if result == 'loss'

      return 'loss' if result == 'win'

      'draw'
    end

    def format(ranking)
      ranking = ranking.sort_by { |_, v| v['P'] }.reverse
      result = "Team                           | MP |  W |  D |  L |  P\n"
      ranking.each do |v|
        result += "#{v[0].ljust(30)} |  #{v[1]['MP']} |  #{v[1]['W']} |  #{v[1]['D']} |  #{v[1]['L']} |  #{v[1]['P']}\n"
      end
      result
    end

    def add_team(team, ranking)
      ranking[team] = { 'MP' => 0, 'W' => 0, 'D' => 0, 'L' => 0, 'P' => 0 }
    end

    def count_match(team, ranking, result)
      ranking[team]['MP'] += 1
      ranking[team][convert(result)] += 1
      if result == 'win'
        ranking[team]['P'] += 3
      elsif result == 'draw'
        ranking[team]['P'] += 1
      else
        ranking[team]['P'] += 0
      end
    end

    def convert(result)
      return 'W' if result == 'win'
      return 'D' if result == 'draw'

      'L'
    end
  end
end
