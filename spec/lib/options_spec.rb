# require 'spec_helper'
# require 'miniatura/options'

# RSpec.describe "to_options" do

#   it "runs with options" do
#     options = Miniatura::Options.new({:size => "40"})
#     expect(options.to_options).to eq("-s 40 -vframes 1")
#   end

#   it "runs with options" do
#     options = Miniatura::Options.new({:time_frame => '00:00:04'})
#     expect(options.to_options).to eq( "-ss 00:00:04 -vframes 1")
#   end

#   it "runs with options" do
#     options = Miniatura::Options.new({:file_extension => "jpg"})
#     expect(options.to_options).to eq("  -vframes 1")
#   end

#   it "runs with options" do
#     options = Miniatura::Options.new({:rotate => 90})
#     expect(options.to_options).to eq("-vf transpose=1 -vframes 1")
#   end

#   it "runs with options" do
#     options = Miniatura::Options.new({:quality => 5})
#     expect(options.to_options).to eq("-q 5 -vframes 1")
#   end

#   it "runs with options" do
#     options = Miniatura::Options.new({:size => "40", :time_frame => '00:00:04', :file_extension => "jpg", :rotate => 90, :quality => 5})
#     expect(options.to_options).to eq("-s 40 -ss 00:00:04   -vf transpose=1 -q 5 -vframes 1")
#   end

# end
