module Miniatura
	class Logger
		attr_reader :logger

		def initialize(options)
			(options.has_key? :logger) ? user_defined_logger : default_logger
		end

		def user_defined_logger
			@logger = options[:logger]
		end

		def default_logger
			@logger = Logger.new(STDOUT)
			@logger.level = Logger::INFO
		end
	end
end
