require 'open3'
require 'miniatura/version'
require 'miniatura/options'
require 'miniatura/logger'
require 'miniatura/generate_command'

module Miniatura
  def generate_thumb(options = {})
    @exit_code, @error = nil
    raise Errno::ENOENT unless File.exist?(current_path)
    options[:file_extension] ||= 'jpeg'
    options[:logger] = Rails.logger
    options[:rotate] = 0
    options[:size] = determine_thumb_dimension_ratio_from_uploaded_video(options[:size])
    tmp_path = generate_temp_file(options[:file_extension])
    cmd = generate_command_for_thumbnail(options, tmp_path)
    show_logs(options, cmd)
    execute_command(cmd)
    handle_exit_code(@exit_code, @error, logger)
    File.rename tmp_path, current_path
  end

  private

  def determine_thumb_dimension_ratio_from_uploaded_video(size)
    video = MiniExiftool.new(current_path)
    orientation = video.rotation
    image_width, image_height = video_dimension(orientation, video.imagewidth, video.imageheight, size)
    return "#{image_width.to_i}" + 'x' + "#{image_height.to_i}"
  end

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

  def generate_temp_file(file_extension)
    File.join(File.dirname(current_path), "tmpfile.#{file_extension}")
  end

  def generate_command_for_thumbnail(options, temp_file_path)
    thumbnail = GenerateCommand.new(current_path, temp_file_path)
    return thumbnail.generate_command(options)
  end

  def show_logs(options, command)
    logger = Miniatura::Logger.new(options).logger
    logger.info("Running command: #{command}")
  end

  def execute_command(command)
    Open3.popen3(command) do |stdin, stdout, stderr, wait_thr|
      @error = stderr.read
      @exit_code = wait_thr.value
    end
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
