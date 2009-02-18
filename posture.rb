require 'rubygems'
require 'sinatra'
require 'json'
require 'sequel'

configure do
  DB = Sequel.connect('sqlite://posture.sqlite')

  begin
    DB.create_table :images do
      primary_key :id
      String :filename
      Time :created_at
    end
  rescue Sequel::DatabaseError
    # table exists!
  end
end

class Image < Sequel::Model
  before_create do
    self.created_at = Time.now
  end

  def to_hash
    self.class.columns.inject({}) { |hash, column| hash[column] = self.send(column); hash }
  end

  def to_json
    to_hash.to_json
  end
end

get '/' do
  "Check your posture?"
end

post '/' do
  FileUtils.mv params[:data][:tempfile].path, 'public/images/' + params[:data][:filename]
  @image = Image.create(:filename => params[:data][:filename])
  
  content_type 'application/json'
  @image.to_json
end

get '/current' do
  @image = Image.order(:created_at.desc).first
  haml :current
end
