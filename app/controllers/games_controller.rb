class GamesController < ApplicationController
  before_action :set_default_response_format

  def index
    response = { 
                 count: Game.count,
                 first_id: Game.first.id,
                 last_id: Game.last.id
               }

    render json: response
  end

  def show
    game = Game.find_by_id(params[:id])
    response = game ? game : { message: "Game with #{params[:id]} dosent exist" }
    
    render json: response
  end

  def details
    game = Game.find_by_id(params[:game_id])
    response = game.nil? ? { message: "Game with #{params[:game_id]} dosent exist" } : details_for(game)

    render json: response
  end

  def kill_modes
    unless params[:game_id] == 'nill'
      game = Game.find_by_id(params[:game_id])
      response = game.nil? ? { message: "Game with #{params[:game_id]} dosent exist" } : kill_modes_for(game)
    else
      response = {}
      Game.all.each do |game|
        response["game-#{game.id}"] = kill_modes_for(game)
      end
    end

    render json: response    
  end

  def kill_modes_for(game)
    kills_by_means = {}
    
    game.kills.each do |kill|
      if kills_by_means.has_key? kill.method
        kills_by_means[kill.method] += 1
      else
        kills_by_means[kill.method] = 1
      end
    end

    kills_by_means
  end

  def details_for(game)
    player_kills = game.real_players.map { |player| [player.name, 
                                       player.kills.where(game: game).count]
                                     }
    {
      id: game.id,
      total_kills: game.kills.count,
      players: game.real_players.map(&:name),
      kills: Hash[*player_kills.flatten]
     }    
  end
end