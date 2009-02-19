ENV['GEM_PATH'] = '/home/stevetooke/.gems'
Gem.clear_paths
gem("rack", "0.9.1")
require 'rubygems'

require 'sinatra'

Sinatra::Application.default_options.merge!(
  :run => false,
  :env => :production
)

require 'posture'

run Sinatra::Application