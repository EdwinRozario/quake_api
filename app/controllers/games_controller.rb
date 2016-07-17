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
    game = Game.find_by_id(params[:id])

    response = {
                id: game.id,
                total_kills: game.kills.count,
                players: game.players.map(&)

               }
  end
end

    # game_1: {
    #     total_kills: 45;
    #     players: ["Dono da bola", "Isgalamido", "Zeh"]
    #     kills: {
    #       "Dono da bola": 5,
    #       "Isgalamido": 18,
    #       "Zeh": 20
    #     }
    #   }