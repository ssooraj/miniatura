module Miniatura
  class GenerateCommand

    attr_reader :input_path, :output_path

    def initialize(in_path, out_path)
      @input_path = in_path
      @output_path = out_path
    end
    
    # Generates ffmpeg command to create the thumbnail.
    def generate_command(options = {})
      options = Miniatura::Options.new(options)
      %Q(ffmpeg #{options.to_options} #{output_path} -i #{input_path})
    end
  end
end