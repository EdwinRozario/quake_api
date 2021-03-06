# Class to help with parsing quake logs
# @author Edwin
class GameLog
  attr_writer :log

  GENRE = ['InitGame', 'Kill']

  def initialize(log)
    @log = log
  end

  def genre
    GENRE.each {|i| return i if @log.include?(i) }
    return false
  end

  def kill_attributes
    @log = @log.match(/[a-zA-Z<> ]* killed [a-zA-Z ]* by [A-Z_]*/).to_s.strip

    { killer: get_killer_name, victim: get_victim_name, method: get_method }
  end

  def get_killer_name
    @log.match(/(.*)(?= killed)/).to_s
  end

  def get_victim_name
    @log.match(/(?<=killed )(.*)(?= by)/).to_s
  end

  def get_method
    @log.match(/(?<=by )(.*)/).to_s
  end

  def create_kill(game)
    attributes = kill_attributes

    Kill.create({
      killer: get_player_with(attributes[:killer], game),
      victim: get_player_with(attributes[:victim], game),
      method: kill_attributes[:method],
      game: game
    })    
  end

  def get_player_with(name, game)
    killer = Player.find_by_name(name)
    if killer
      unless game.players.include? killer
        GamePlayer.create(game: game, player: killer)
      end
    else
      killer = Player.create(name: name)
      GamePlayer.create(game: game, player: killer)
    end
    killer
  end
end