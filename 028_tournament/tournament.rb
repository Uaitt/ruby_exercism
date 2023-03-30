class Tournament
  POINTS_FOR = { 'win' => 3, 'draw' => 1, 'loss' => 0 }.freeze
  SWAP = { 'win' => 'loss',  'draw' => 'draw', 'loss' => 'win' }.freeze
  CONVERT = { 'win' => 'W', 'draw' => 'D', 'loss' => 'L' }.freeze
  INITIAL_STATE =
  class << self
    def tally(tournament, ranking = {})
      add_teams(ranking, tournament)
      add_points(ranking, tournament)
      ranking = sort(ranking)
      format(ranking)
    end

    private

    def add_teams(ranking, tournament)
      matches = tournament.split("\n")
      matches.each do |match|
        team1, team2 = match.split(';')
        add_team(team1, ranking)
        add_team(team2, ranking)
      end
    end

    def add_points(ranking, tournament)
      matches = tournament.split("\n")
      matches.each do |match|
        team1, team2, result = match.split(';')
        count_match(team1, ranking, result)
        result = SWAP[result]
        count_match(team2, ranking, result)
      end
    end

    def sort(ranking)
      ranking.sort { |a, b| [a[1]['P'], b[0]] <=> [b[1]['P'], a[0]] }.reverse
    end

    def format(ranking)
      result = "#{'Team'.ljust(30)} | MP |  W |  D |  L |  P\n"
      ranking.each do |r|
        result += "#{r[0].ljust(30)} |  #{r[1]['MP']} |  #{r[1]['W']} |  #{r[1]['D']} |  #{r[1]['L']} | #{r[1]['P'].to_s.rjust(2)}\n"
      end
      result
    end

    def add_team(team, ranking)
      ranking[team] ||= { 'MP' => 0, 'W' => 0, 'D' => 0, 'L' => 0, 'P' => 0 }
    end

    def count_match(team, ranking, result)
      ranking[team]['MP'] += 1
      ranking[team][CONVERT[result]] += 1
      ranking[team]['P'] += POINTS_FOR[result]
    end
  end
end
