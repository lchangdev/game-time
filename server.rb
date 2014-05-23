require 'sinatra'
require 'csv'
require 'shotgun'
require 'pry'

def load_data
  master_data = []
  CSV.foreach('team_data.csv', headers: true, header_converters: :symbol) do |row|
    master_data << row
  end

  master_data
end

def team_data
  teams_data = []
  wins_loss_data ={}

  CSV.foreach('team_data.csv', headers: true, header_converters: :symbol) do |row|
  teams_data << row[:home_team]
  teams_data << row[:away_team]
  end

  teams = teams_data.uniq
  teams.each do |team|
    wins_loss_data[team.to_sym] = [:wins,:losses]
  end

  wins_loss_data
end


get '/' do

  erb :index
end

get '/leaderboard' do
  @entire_data = load_data
  @leaderboard_data = team_data

  load_data.each do |x|

    if load_data[:home_score] > load_data[:away_score]
      if load_data[:home_team] == team_data[]


  erb :leaderboard
end
