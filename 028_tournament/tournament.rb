class Tournament
  class << self
    def tally(tournament, ranking = {})
      add_teams(ranking, tournament)
      add_points(ranking, tournament)
      format(ranking)
    end

    private

    def add_teams(ranking, tournament)
      matches = tournament.split("\n")
      matches.each do |match|
        team1, team2 = match.split(';')
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

    def format(ranking)
      ranking = ranking.sort { |a, b| [a[1]['P'], b[0]] <=> [b[1]['P'], a[0]] }.reverse
      result = "Team                           | MP |  W |  D |  L |  P\n"
      ranking.each do |r|
        result += "#{r[0].ljust(30)} |  #{r[1]['MP']} |  #{r[1]['W']} |  #{r[1]['D']} |  #{r[1]['L']} | #{r[1]['P'].to_s.rjust(2)}\n"
      end
      result
    end

    def add_team(team, ranking)
      ranking[team] = { 'MP' => 0, 'W' => 0, 'D' => 0, 'L' => 0, 'P' => 0 }
    end

    def count_match(team, ranking, result)
      ranking[team]['MP'] += 1
      ranking[team][convert(result)] += 1
      ranking[team]['P'] += points_for(result)
    end

    def convert(result)
      return 'W' if result == 'win'
      return 'D' if result == 'draw'

      'L'
    end

    def points_for(result)
      return 3 if result == 'win'
      return 1 if result == 'draw'

      0
    end

    def swap(result)
      return 'win' if result == 'loss'
      return 'loss' if result == 'win'

      'draw'
    end
  end
end
