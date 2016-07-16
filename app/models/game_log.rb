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

	def get_killer_name
		@log = @log.match(/[a-zA-Z<> ]* killed [a-zA-Z ]* by [A-Z_]*/).to_s.strip
		@log.match(/(.*)(?= killed)/).to_s
	end

	def get_victim_name
		@log = @log.match(/[a-zA-Z<> ]* killed [a-zA-Z ]* by [A-Z_]*/).to_s.strip
		@log.match(/(?<=killed )(.*)(?= by)/).to_s
	end

	def get_method
		@log = @log.match(/[a-zA-Z<> ]* killed [a-zA-Z ]* by [A-Z_]*/).to_s.strip
		@log.match(/(?<=by )(.*)/).to_s
	end	
end