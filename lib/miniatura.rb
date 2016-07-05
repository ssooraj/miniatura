require "open3"
require "miniatura/version"
require "miniatura/options"
require "miniatura/logger"
require "miniatura/generate_command"
require 'mini_exiftool'

module Miniatura
  def generate_thumb options = {}
    options[:file_extension] ||= 'jpeg'
    options[:logger] = Rails.logger
    options[:rotate] = 0
    # options[:rotate]
    # p video = MiniExiftool.new(current_path)
    # p "before"
    # p options
    # p orientation = video.rotation
    # case orientation
    # when 0
    #   options[:rotate] = 0
    # when 90
    #   options[:rotate] = 0
    # when 180
    #   options[:rotate] = 180
    # end
    # p "after"
    p options
    tmp_path = File.join( File.dirname(current_path), "tmpfile.#{options[:file_extension]}")
    thumbnail = GenerateCommand.new(current_path, tmp_path)
    cmd = thumbnail.generate_command(options)
    logger = Miniatura::Logger.new(options).logger
    logger.info("Running command: #{cmd}")
    exit_code, error = nil
    raise Errno::ENOENT unless File.exist?(current_path)
    Open3.popen3(cmd) do |stdin, stdout, stderr, wait_thr|
      error =  stderr.read
      exit_code = wait_thr.value
    end
    handle_exit_code(exit_code, error, logger)
    File.rename tmp_path, current_path
  end

  private

  def handle_exit_code(exit_code, error, logger)
    if exit_code == 0
      logger.info "Success!"
    else
      logger.error "Failure due to following error:  #{error}"
    end
    exit_code
  end
end
