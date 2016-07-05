# Miniatura

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/miniatura`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'miniatura'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install miniatura

# Usage

In the Rails app/uploaders/filename.rb, call the generate_thumb function with options.
The options are passed as hash to this function, can be also empty.

The options are:

* size - The height x width of the thumbnail to be generated, by default will take the same size of that of the video, type is string.
* file_extension - Format of the file to be saved, by default the format at will be "jpeg", type is string.
* quality - Quality of the file to be saved, type is integer.
* time_frame - The time in the video at which the thumbnail must be generated, type is string.


## Examples

Here's a working example:

In your Rails app/uploaders/video_uploader.rb:

```ruby
class VideoUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
  include Miniatura
  storage :file

  version :thumb do
     process generate_thumb:[{:size => "200x200",:quality => 5, :time_frame => "00:0:04", :file_extension => "jpeg"}]
    def full_filename for_file
      png_name for_file, version_name, "jpeg"
    end
  end

  def png_name for_file, version_name, format
    %Q{#{version_name}_#{for_file.chomp(File.extname(for_file))}.#{format}}
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/miniatura. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

