module Miniatura
	class Logger
		attr_reader :logger

		def initialize
			@logger = Rails.logger
		end
	end
end
