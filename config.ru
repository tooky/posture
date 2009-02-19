ENV['GEM_PATH'] = '/home/stevetooke/.gems:/usr/lib/ruby/gems/1.8'
require 'rubygems'
require 'sinatra'

Sinatra::Application.default_options.merge!(
  :run => false,
  :env => :production
)

require 'posture'

run Sinatra::Application