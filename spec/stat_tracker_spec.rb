require '../cross_check/lib/stat_tracker'

RSpec.describe StatTracker do
  before(:all) do
    game_path = './data/game.csv'
    team_path = './data/team_info.csv'
    game_teams_path = './data/game_teams_stats.csv'

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
    expect(@stat_tracker.highest_total_score).to eq 15
  end

  it "#lowest_total_score" do
    expect(@stat_tracker.lowest_total_score).to eq 1
  end

  it "#biggest_blowout" do
    expect(@stat_tracker.biggest_blowout).to eq 10
  end

  it "#percentage_home_wins" do
    expect(@stat_tracker.percentage_home_wins).to eq 0.55
  end

  it "#percentage_visitor_wins" do
    expect(@stat_tracker.percentage_visitor_wins).to eq 0.45
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
    expect(@stat_tracker.average_goals_per_game).to eq 5.54
  end

  it "#average_goals_by_season" do
    expected = {
      "20122013"=>5.4,
      "20162017"=>5.51,
      "20142015"=>5.43,
      "20152016"=>5.41,
      "20132014"=>5.5,
      "20172018"=>5.94
    }
    expect(@stat_tracker.average_goals_by_season).to eq expected
  end

  it "#count_of_teams" do
    expect(@stat_tracker.count_of_teams).to eq 32
  end

  it "#best_offense" do
    expect(@stat_tracker.best_offense).to eq "Golden Knights"
  end

  it "#worst_offense" do
    expect(@stat_tracker.worst_offense).to eq "Sabres"
  end

  it "#best_defense" do
    expect(@stat_tracker.best_defense).to eq "Kings"
  end

  it "#worst_defense" do
    expect(@stat_tracker.worst_defense).to eq "Coyotes"
  end

  it "#highest_scoring_visitor" do
    expect(@stat_tracker.highest_scoring_visitor).to eq "Capitals"
  end

  it "#highest_scoring_home_team" do
    expect(@stat_tracker.highest_scoring_home_team).to eq "Golden Knights"
  end

  it "#lowest_scoring_visitor" do
    expect(@stat_tracker.lowest_scoring_visitor).to eq "Sabres"
  end

  it "#lowest_scoring_home_team" do
    expect(@stat_tracker.lowest_scoring_home_team).to eq "Sabres"
  end

  it "#winningest_team" do
    expect(@stat_tracker.winningest_team).to eq "Golden Knights"
  end

  it "#best_fans" do
    expect(@stat_tracker.best_fans).to eq "Coyotes"
  end

  it "#worst_fans" do
    expect(@stat_tracker.worst_fans).to eq []
  end

  xit "#team_info" do
    expected = {
      "team_id" => "18",
      "franchise_id" => "34",
      "short_name" => "Nashville",
      "team_name" => "Predators",
      "abbreviation" => "NSH",
      "link" => "/api/v1/teams/18"
    }

    expect(@stat_tracker.team_info("18")).to eq expected
  end

  xit "#best_season" do
    expect(@stat_tracker.best_season("6")).to eq "20132014"
  end

  xit "#worst_season" do
    expect(@stat_tracker.worst_season("6")).to eq "20142015"
  end

  xit "#average_win_percentage" do
    expect(@stat_tracker.average_win_percentage("18")).to eq 0.52
  end

  xit "#most_goals_scored" do
    expect(@stat_tracker.most_goals_scored("18")).to eq 9
  end

  xit "#fewest_goals_scored" do
    expect(@stat_tracker.fewest_goals_scored("18")).to eq 0
  end

  xit "#favorite_opponent" do
    expect(@stat_tracker.favorite_opponent("18")).to eq "Oilers"
  end

  xit "#rival" do
    expect(@stat_tracker.rival("18")).to eq "Red Wings"
  end

  xit "#biggest_team_blowout" do
    expect(@stat_tracker.biggest_team_blowout("18")).to eq 7
  end

  xit "#worst_loss" do
    expect(@stat_tracker.worst_loss("18")).to eq 6
  end

  xit "#head_to_head" do
    expected = {
      "Blues" => 0.47,
      "Jets" => 0.55,
      "Avalanche" => 0.63,
      "Flames" => 0.44,
      "Red Wings" => 0.29,
      "Blue Jackets" => 0.6,
      "Stars" => 0.52,
      "Blackhawks" => 0.42,
      "Wild" => 0.44,
      "Devils" => 0.5,
      "Canadiens" => 0.6,
      "Canucks" => 0.5,
      "Rangers" => 0.4,
      "Lightning" => 0.7,
      "Capitals" => 0.7,
      "Sharks" => 0.6,
      "Oilers" => 0.78,
      "Ducks" => 0.48,
      "Penguins" => 0.31,
      "Islanders" => 0.4,
      "Kings" => 0.61,
      "Sabres" => 0.7,
      "Coyotes" => 0.67,
      "Bruins" => 0.5,
      "Panthers" => 0.5,
      "Maple Leafs" => 0.4,
      "Senators" => 0.7,
      "Hurricanes" => 0.3,
      "Golden Knights" => 0.33,
      "Flyers" => 0.5
    }

    expect(@stat_tracker.head_to_head("18")).to eq expected
  end

  xit "#seasonal_summary" do
    expected = {
      "20162017" => {
        postseason: {
          :win_percentage=>0.64,
          :total_goals_scored=>60,
          :total_goals_against=>48,
          :average_goals_scored=>2.73,
          :average_goals_against=>2.18},
          :regular_season => {
            :win_percentage=>0.5,
            :total_goals_scored=>240,
            :total_goals_against=>224,
            :average_goals_scored=>2.93,
            :average_goals_against=>2.73
          }
        },
        "20172018" => {
          postseason: {
            :win_percentage=>0.54,
            :total_goals_scored=>41,
            :total_goals_against=>42,
            :average_goals_scored=>3.15,
            :average_goals_against=>3.23
          },
          :regular_season=>
          {:win_percentage=>0.65,
            :total_goals_scored=>267,
            :total_goals_against=>211,
            :average_goals_scored=>3.26,
            :average_goals_against=>2.57
          }
        },
        "20132014" => {
          postseason: {
            :win_percentage=>0.0,
            :total_goals_scored=>0,
            :total_goals_against=>0,
            :average_goals_scored=>0.0,
            :average_goals_against=>0.0
          },
          :regular_season=>
          {
            :win_percentage=>0.46,
            :total_goals_scored=>216,
            :total_goals_against=>242,
            :average_goals_scored=>2.63,
            :average_goals_against=>2.95
          }
        },
        "20122013" => {
          postseason: {
            :win_percentage=>0.0,
            :total_goals_scored=>0,
            :total_goals_against=>0,
            :average_goals_scored=>0.0,
            :average_goals_against=>0.0
          },
          :regular_season=>
          {
            :win_percentage=>0.33,
            :total_goals_scored=>111,
            :total_goals_against=>139,
            :average_goals_scored=>2.31,
            :average_goals_against=>2.9
          }
        },
        "20142015" => {
          postseason: {
            :win_percentage=>0.33,
            :total_goals_scored=>21,
            :total_goals_against=>19,
            :average_goals_scored=>3.5,
            :average_goals_against=>3.17
          },
          :regular_season=>
          {
            :win_percentage=>0.57,
            :total_goals_scored=>232,
            :total_goals_against=>208,
            :average_goals_scored=>2.83,
            :average_goals_against=>2.54
          }
        },
        "20152016" => {
          postseason: {
            :win_percentage=>0.5,
            :total_goals_scored=>31,
            :total_goals_against=>43,
            :average_goals_scored=>2.21,
            :average_goals_against=>3.07
          },
          :regular_season=>
          {
            :win_percentage=>0.5,
            :total_goals_scored=>228,
            :total_goals_against=>215,
            :average_goals_scored=>2.78,
            :average_goals_against=>2.62
          }
        }
      }
      expect(@stat_tracker.seasonal_summary("18")).to eq expected
    end

    xit "#biggest_bust" do
      expect(@stat_tracker.biggest_bust("20132014")).to eq "Lightning"
      expect(@stat_tracker.biggest_bust("20142015")).to eq "Jets"
    end

    xit "#biggest_surprise" do
      expect(@stat_tracker.biggest_surprise("20132014")).to eq "Kings"
      expect(@stat_tracker.biggest_surprise("20142015")).to eq "Blackhawks"
    end

    xit "#winningest_coach" do
      expect(@stat_tracker.winningest_coach("20132014")).to eq "Claude Julien"
      expect(@stat_tracker.winningest_coach("20142015")).to eq "Alain Vigneault"
    end

    xit "#worst_coach" do
      expect(@stat_tracker.worst_coach("20132014")).to eq "Peter Laviolette"
      expect(@stat_tracker.worst_coach("20142015")).to eq "Craig MacTavish"
    end

    xit "#most_accurate_team" do
      expect(@stat_tracker.most_accurate_team("20132014")).to eq "Ducks"
      expect(@stat_tracker.most_accurate_team("20142015")).to eq "Flames"
    end

    xit "#least_accurate_team" do
      expect(@stat_tracker.least_accurate_team("20132014")).to eq "Sabres"
      expect(@stat_tracker.least_accurate_team("20142015")).to eq "Coyotes"
    end

    xit "#most_hits" do
      expect(@stat_tracker.most_hits("20132014")).to eq "Kings"
      expect(@stat_tracker.most_hits("20142015")).to eq "Islanders"
    end

    xit "#fewest_hits" do
      expect(@stat_tracker.fewest_hits("20132014")).to eq "Devils"
      expect(@stat_tracker.fewest_hits("20142015")).to eq "Wild"
    end

    xit "#power_play_goal_percentage" do
      expect(@stat_tracker.power_play_goal_percentage("20132014")).to eq 0.22
      expect(@stat_tracker.power_play_goal_percentage("20142015")).to eq 0.21
    end
end
