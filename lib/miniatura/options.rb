module Miniatura
  class Options
    #Options class to add various options to the ffmpeg command generated.

    CLI_KEY = {
        size: '-s',
        time_frame: '-ss',
        quality: '-q',
        file_extension: '-c'
    }

    def initialize(options)
      @options = options
    end

    def to_options
      result = @options.map { |k, v| send(k.to_s, v) }
      result << '-vframes 1'
      result.join(' ')
    end

    def file_extension(value)
      case value
        when 'jpeg'
          '-c mjpeg'
        when 'png'
          '-c png'
        else
          ''
      end
    end

    def rotate(value)
      case value
        when 90
          '-vf transpose=1'
        when 180
          '-vf hflip '
        when 270
          '-vf transpose=2'
        else
          ''
      end
    end

    def method_missing(name, *args)
      "#{CLI_KEY[name]} #{args[0]}" if CLI_KEY.has_key? name
    end
  end
end
