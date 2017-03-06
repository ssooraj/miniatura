require 'open3'
require 'miniatura/version'
require 'miniatura/options'
require 'miniatura/logger'
require 'miniatura/generate_command'

module Miniatura
  def generate_thumb(options = {})
    options[:file_extension] ||= 'jpeg'
    options[:logger] = Rails.logger
    size = options[:size]
    options[:rotate] = 0
    video = MiniExiftool.new(current_path)
    orientation = video.rotation
    image_width, image_height = video_dimension(orientation, video.imagewidth, video.imageheight, size)
    options[:size] = "#{image_width.to_i}" + "x" + "#{image_height.to_i}"
    tmp_path = File.join(File.dirname(current_path), "tmpfile.#{options[:file_extension]}")
    thumbnail = GenerateCommand.new(current_path, tmp_path)
    cmd = thumbnail.generate_command(options)
    logger = Miniatura::Logger.new(options).logger
    logger.info("Running command: #{cmd}")
    exit_code, error = nil
    raise Errno::ENOENT unless File.exist?(current_path)
    Open3.popen3(cmd) do |stdin, stdout, stderr, wait_thr|
      error = stderr.read
      exit_code = wait_thr.value
    end
    handle_exit_code(exit_code, error, logger)
    File.rename tmp_path, current_path
  end

  private

  def video_dimension(orientation, video_width, video_height, size)
    case orientation
      when 0, 180
        image_width, image_height = find_width_and_height_of_landscape_video(video_width, video_height, size)
      else
        image_width, image_height = find_width_and_height_of_portrait_video(video_width, video_height, size)
    end
    return image_width, image_height
  end

  def find_width_and_height_of_portrait_video(video_width, video_height, size)
    ratio = size.to_f/video_height
    image_width = size
    image_height = video_width * ratio
    return image_width, image_height
  end

  def find_width_and_height_of_landscape_video(video_width, video_height, size)
    ratio = size.to_f/video_width
    image_width = size
    image_height = video_height * ratio
    return image_width, image_height
  end

  def handle_exit_code(exit_code, error, logger)
    if exit_code == 0
      logger.info 'Success!'
    else
      logger.error "Failure due to following error:  #{error}"
    end
    exit_code
  end
end
