namespace :parser do
  desc 'Loads the quake logs to db'
  task load: :environment do
    log_file = File.join(Rails.root, 'db', 'data', 'quake.log')
    
    logs = File.open(log_file, 'r')
    progressbar = RakeProgressbar.new(logs.count)

    logs = File.open(log_file, 'r') # logs were made empty once .count was called on it
    current_game = nil

    logs.each_line do |log|
      game_log = GameLog.new(log.strip)

      case game_log.genre
        when 'InitGame' then current_game = Game.create
        when 'Kill' then game_log.create_kill(current_game)
        else next
      end
      progressbar.inc
    end

    progressbar.finished
  end
end
