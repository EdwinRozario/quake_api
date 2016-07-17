class KillsController < ApplicationController
  before_action :set_default_response_format

  def index
    response = { 
                 count: Kill.count,
                 first_id: Kill.first.id,
                 last_id: Kill.last.id
               }

    render json: response
  end

  def show
    kill = Kill.find_by_id(params[:id])
    response = kill ? kill : { message: "Kill with #{params[:id]} dosent exist" }
    render json: response
  end

  def details
    kill = Kill.find_by_id(params[:kill_id])
    response = kill.nil? ? { message: "Kill with #{params[:kill_id]} dosent exist" } : details_for(kill)

    render json: response
  end

  def details_for(kill)
  	{ 
  		killer: kill.killer.name, victim: kill.victim.name,
  		method: kill.method, game_id: kill.game.id
  	}
  end
end
