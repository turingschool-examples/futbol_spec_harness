require '../futbol/lib/stat_tracker'

RSpec.describe StatTracker do
  before(:all) do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  it "exists" do
    expect(@stat_tracker).to be_an_instance_of StatTracker
  end

  it "#highest_total_score" do
    expect(@stat_tracker.highest_total_score).to eq 11
  end

  it "#lowest_total_score" do
    expect(@stat_tracker.lowest_total_score).to eq 0
  end

  it "#biggest_blowout" do
    expect(@stat_tracker.biggest_blowout).to eq 8
  end

  it "#percentage_home_wins" do
    expect(@stat_tracker.percentage_home_wins).to eq 0.44
  end

  it "#percentage_visitor_wins" do
    expect(@stat_tracker.percentage_visitor_wins).to eq 0.36
  end

  it "#percentage_ties" do
    expect(@stat_tracker.percentage_ties).to eq 0.20
  end

  it "#count_of_games_by_season" do
    expected = {
      "20122013"=>806,
      "20162017"=>1317,
      "20142015"=>1319,
      "20152016"=>1321,
      "20132014"=>1323,
      "20172018"=>1355
    }
    expect(@stat_tracker.count_of_games_by_season).to eq expected
  end

  it "#average_goals_per_game" do
    expect(@stat_tracker.average_goals_per_game).to eq 4.22
  end

  it "#average_goals_by_season" do
    expected = {
      "20122013"=>4.12,
      "20162017"=>4.23,
      "20142015"=>4.14,
      "20152016"=>4.16,
      "20132014"=>4.19,
      "20172018"=>4.44
    }
    expect(@stat_tracker.average_goals_by_season).to eq expected
  end

  it "#count_of_teams" do
    expect(@stat_tracker.count_of_teams).to eq 32
  end

  it "#best_offense" do
    expect(@stat_tracker.best_offense).to eq "Reign FC"
  end

  it "#worst_offense" do
    expect(@stat_tracker.worst_offense).to eq "Utah Royals FC"
  end

  it "#best_defense" do
    expect(@stat_tracker.best_defense).to eq "FC Cincinnati"
  end

  it "#worst_defense" do
    expect(@stat_tracker.worst_defense).to eq "Columbus Crew SC"
  end

  it "#highest_scoring_visitor" do
    expect(@stat_tracker.highest_scoring_visitor).to eq "FC Dallas"
  end

  it "#highest_scoring_home_team" do
    expect(@stat_tracker.highest_scoring_home_team).to eq "Reign FC"
  end

  it "#lowest_scoring_visitor" do
    expect(@stat_tracker.lowest_scoring_visitor).to eq "San Jose Earthquakes"
  end

  it "#lowest_scoring_home_team" do
    expect(@stat_tracker.lowest_scoring_home_team).to eq "Utah Royals FC"
  end

  it "#winningest_team" do
    expect(@stat_tracker.winningest_team).to eq "Reign FC"
  end

  it "#best_fans" do
    expect(@stat_tracker.best_fans).to eq "San Jose Earthquakes"
  end

  it "#worst_fans" do
    expect(@stat_tracker.worst_fans).to eq ["Houston Dynamo", "Utah Royals FC"]
  end

  it "#team_info" do
    expected = {
      "team_id" => "18",
      "franchise_id" => "34",
      "team_name" => "Minnesota United FC",
      "abbreviation" => "MIN",
      "link" => "/api/v1/teams/18"
    }

    expect(@stat_tracker.team_info("18")).to eq expected
  end

  it "#best_season" do
    expect(@stat_tracker.best_season("6")).to eq "20132014"
  end

  it "#worst_season" do
    expect(@stat_tracker.worst_season("6")).to eq "20142015"
  end

  it "#average_win_percentage" do
    expect(@stat_tracker.average_win_percentage("6")).to eq 0.49
  end

  it "#most_goals_scored" do
    expect(@stat_tracker.most_goals_scored("18")).to eq 7
  end

  it "#fewest_goals_scored" do
    expect(@stat_tracker.fewest_goals_scored("18")).to eq 0
  end

  it "#favorite_opponent" do
    expect(@stat_tracker.favorite_opponent("18")).to eq "DC United"
  end

  it "#rival" do
    expect(@stat_tracker.rival("18")).to eq "Houston Dash"
  end

  it "#biggest_team_blowout" do
    expect(@stat_tracker.biggest_team_blowout("18")).to eq 5
  end

  it "#worst_loss" do
    expect(@stat_tracker.worst_loss("18")).to eq 4
  end

  it "#head_to_head" do
    expected = {
     "Atlanta United"=>0.5,
     "Chicago Fire"=>0.3,
     "FC Cincinnati"=>0.39,
     "DC United"=>0.8,
     "FC Dallas"=>0.4,
     "Houston Dynamo"=>0.4,
     "Sporting Kansas City"=>0.25,
     "LA Galaxy"=>0.29,
     "Los Angeles FC"=>0.44,
     "Montreal Impact"=>0.33,
     "New England Revolution"=>0.47,
     "New York City FC"=>0.6,
     "New York Red Bulls"=>0.4,
     "Orlando City SC"=>0.37,
     "Portland Timbers"=>0.3,
     "Philadelphia Union"=>0.44,
     "Real Salt Lake"=>0.42,
     "San Jose Earthquakes"=>0.33,
     "Seattle Sounders FC"=>0.5,
     "Toronto FC"=>0.33,
     "Vancouver Whitecaps FC"=>0.44,
     "Chicago Red Stars"=>0.48,
     "Houston Dash"=>0.1,
     "North Carolina Courage"=>0.2,
     "Orlando Pride"=>0.47,
     "Portland Thorns FC"=>0.45,
     "Reign FC"=>0.33,
     "Sky Blue FC"=>0.3,
     "Utah Royals FC"=>0.6,
     "Washington Spirit FC"=>0.67,
     "Columbus Crew SC"=>0.5
    }

    expect(@stat_tracker.head_to_head("18")).to eq expected
  end

  it "#seasonal_summary" do
    expected = {"20162017"=>
        {:postseason=>
          {:win_percentage=>0.59,
           :total_goals_scored=>48,
           :total_goals_against=>40,
           :average_goals_scored=>2.18,
           :average_goals_against=>1.82},
         :regular_season=>
          {:win_percentage=>0.38,
           :total_goals_scored=>180,
           :total_goals_against=>170,
           :average_goals_scored=>2.2,
           :average_goals_against=>2.07}},
       "20172018"=>
        {:postseason=>
          {:win_percentage=>0.54,
           :total_goals_scored=>29,
           :total_goals_against=>28,
           :average_goals_scored=>2.23,
           :average_goals_against=>2.15},
         :regular_season=>
          {:win_percentage=>0.44,
           :total_goals_scored=>187,
           :total_goals_against=>162,
           :average_goals_scored=>2.28,
           :average_goals_against=>1.98}},
       "20132014"=>
        {:postseason=>
          {:win_percentage=>0.0,
           :total_goals_scored=>0,
           :total_goals_against=>0,
           :average_goals_scored=>0.0,
           :average_goals_against=>0.0},
         :regular_season=>
          {:win_percentage=>0.38,
           :total_goals_scored=>166,
           :total_goals_against=>177,
           :average_goals_scored=>2.02,
           :average_goals_against=>2.16}},
       "20122013"=>
        {:postseason=>
          {:win_percentage=>0.0,
           :total_goals_scored=>0,
           :total_goals_against=>0,
           :average_goals_scored=>0.0,
           :average_goals_against=>0.0},
         :regular_season=>
          {:win_percentage=>0.25,
           :total_goals_scored=>85,
           :total_goals_against=>103,
           :average_goals_scored=>1.77,
           :average_goals_against=>2.15}},
       "20142015"=>
        {:postseason=>
          {:win_percentage=>0.67,
           :total_goals_scored=>17,
           :total_goals_against=>13,
           :average_goals_scored=>2.83,
           :average_goals_against=>2.17},
         :regular_season=>
          {:win_percentage=>0.5,
           :total_goals_scored=>186,
           :total_goals_against=>162,
           :average_goals_scored=>2.27,
           :average_goals_against=>1.98}},
       "20152016"=>
        {:postseason=>
          {:win_percentage=>0.36,
           :total_goals_scored=>25,
           :total_goals_against=>33,
           :average_goals_scored=>1.79,
           :average_goals_against=>2.36},
         :regular_season=>
          {:win_percentage=>0.45,
           :total_goals_scored=>178,
           :total_goals_against=>159,
           :average_goals_scored=>2.17,
           :average_goals_against=>1.94}}}

      expect(@stat_tracker.seasonal_summary("18")).to eq expected
    end

    it "#biggest_bust" do
      expect(@stat_tracker.biggest_bust("20132014")).to eq "Montreal Impact"
      expect(@stat_tracker.biggest_bust("20142015")).to eq "Sporting Kansas City"
    end

    it "#biggest_surprise" do
      expect(@stat_tracker.biggest_surprise("20132014")).to eq "FC Cincinnati"
      expect(@stat_tracker.biggest_surprise("20142015")).to eq "Minnesota United FC"
    end

    it "#winningest_coach" do
      expect(@stat_tracker.winningest_coach("20132014")).to eq "Claude Julien"
      expect(@stat_tracker.winningest_coach("20142015")).to eq "Alain Vigneault"
    end

    it "#worst_coach" do
      expect(@stat_tracker.worst_coach("20132014")).to eq "Peter Laviolette"
      expect(@stat_tracker.worst_coach("20142015")).to eq "Craig MacTavish"
    end

    it "#most_accurate_team" do
      expect(@stat_tracker.most_accurate_team("20132014")).to eq "Real Salt Lake"
      expect(@stat_tracker.most_accurate_team("20142015")).to eq "Toronto FC"
    end

    it "#least_accurate_team" do
      expect(@stat_tracker.least_accurate_team("20132014")).to eq "New York City FC"
      expect(@stat_tracker.least_accurate_team("20142015")).to eq "Columbus Crew SC"
    end

    it "#most_tackles" do
      expect(@stat_tracker.most_tackles("20132014")).to eq "FC Cincinnati"
      expect(@stat_tracker.most_tackles("20142015")).to eq "Seattle Sounders FC"
    end

    it "#fewest_tackles" do
      expect(@stat_tracker.fewest_tackles("20132014")).to eq "Atlanta United"
      expect(@stat_tracker.fewest_tackles("20142015")).to eq "Orlando City SC"
    end
end
