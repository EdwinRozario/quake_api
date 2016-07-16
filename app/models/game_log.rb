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
end