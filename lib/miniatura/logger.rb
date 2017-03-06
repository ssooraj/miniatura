module Miniatura
	class Logger
		attr_reader :logger

		def initialize(options)
			(options.has_key? :logger) ? user_defined_logger(options[:logger]) : default_logger
		end

		def user_defined_logger(log_option)
			@logger = log_option
		end

		def default_logger
			@logger = Logger.new(STDOUT)
			@logger.level = Logger::INFO
		end
	end
end
