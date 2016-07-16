class GamesController < ApplicationController
  def index
    respond_to do |format|
      format.json { render(json: {} ) }
    end
  end

  def show
  end

  def details
  end
end
