require 'sinatra'
require 'csv'
require 'shotgun'
require 'pry'

def load_data
  master_data = []
  CSV.foreach('team_data.csv', headers: true, converters: :all) do |row|
    master_data << row.to_hash
  end

  master_data

end

def team_data
  team_name = []

  CSV.foreach('team_names.csv', headers: true, converters: :all) do |row|
  team_name << row.to_hash
  end

  team_name


end

def wins_loss_data

  total_data = []
  teams_data = []
  wl_data ={}
  total_wl_data = {}

  CSV.foreach('team_data.csv', headers: true, converters: :all) do |row|
    total_data << row.to_hash

  end

  CSV.foreach('team_data.csv', headers: true, converters: :all) do |row|
  teams_data << row["home_team"]
  teams_data << row["away_team"]
  end

  teams = teams_data.uniq
  teams.each do |team|
    wl_data[team] = [wins: 0,losses: 0]
  end

  total_wl_data = wl_data

  total_data.each do |x|

    if x["home_score"] > x["away_score"]
      if x["home_team"] == "Patriots"
        total_wl_data["Patriots"][0][:wins] =  total_wl_data["Patriots"][0][:wins] + 1
      elsif x["home_team"] == "Broncos"
        total_wl_data["Broncos"][0][:wins] =  total_wl_data["Broncos"][0][:wins] + 1
      elsif x["home_team"] == "Colts"
        total_wl_data["Colts"][0][:wins] =  total_wl_data["Colts"][0][:wins] + 1
      elsif x["home_team"] == "Steelers"
        total_wl_data["Steelers"][0][:wins] =  total_wl_data["Steelers"][0][:wins] + 1
      end

      if x["away_team"] == "Patriots"
        total_wl_data["Patriots"][0][:losses] =  total_wl_data["Patriots"][0][:losses] - 1
      elsif x["away_team"] == "Broncos"
        total_wl_data["Broncos"][0][:losses] =  total_wl_data["Broncos"][0][:losses] - 1
      elsif x["away_team"] == "Colts"
        total_wl_data["Colts"][0][:losses] =  total_wl_data["Colts"][0][:losses] - 1
      elsif x["away_team"] == "Steelers"
        total_wl_data["Steelers"][0][:losses] =  total_wl_data["Steelers"][0][:losses] - 1
      end
    else

      if x["home_team"] == "Patriots"
        total_wl_data["Patriots"][0][:losses] =  total_wl_data["Patriots"][0][:losses] - 1
      elsif x["home_team"] == "Broncos"
        total_wl_data["Broncos"][0][:losses] =  total_wl_data["Broncos"][0][:losses] - 1
      elsif x["home_team"] == "Colts"
        total_wl_data["Colts"][0][:losses] =  total_wl_data["Colts"][0][:losses] - 1
      elsif x["home_team"] == "Steelers"
        total_wl_data["Steelers"][0][:losses] =  total_wl_data["Steelers"][0][:losses] - 1
      end

      if x["away_team"] == "Patriots"
        total_wl_data["Patriots"][0][:wins] =  total_wl_data["Patriots"][0][:wins] + 1
      elsif x["away_team"] == "Broncos"
        total_wl_data["Broncos"][0][:wins] =  total_wl_data["Broncos"][0][:wins] + 1
      elsif x["away_team"] == "Colts"
        total_wl_data["Colts"][0][:wins] =  total_wl_data["Colts"][0][:wins] + 1
      elsif x["away_team"] == "Steelers"
        total_wl_data["Steelers"][0][:wins] =  total_wl_data["Steelers"][0][:wins] + 1
      end
    end
  end

  total_wl_data

  sorted_teams = {}
  total_wl_data.each do |k,v|

  total = v[0][:wins] + v[0][:losses]
  sorted_teams[total] = [k,v]

  end

  leaderboard_sorted = sorted_teams.sort_by {|k,v| k}.reverse
  Hash[leaderboard_sorted]

end

get '/' do

  erb :index
end

get '/leaderboard' do

  @entire_data = load_data
  @leaderboard_data = wins_loss_data

  erb :leaderboard
end

get '/leaderboard/:team' do
  @entire_data = load_data
  @team_names_data = team_data
  @leaderboard_data = wins_loss_data

  @team_info = @team_names_data.find do |team|

    team[:team_name] == params[:team]

  end

  erb :teamprofile
end


















