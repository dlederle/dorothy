require 'toto'

# Rack config
use Rack::Static, :urls => ['/css', '/js', '/images', '/pdf', '/GEB.html', '/favicon.ico'], :root => 'public'
use Rack::CommonLogger

if ENV['RACK_ENV'] == 'development'
  use Rack::ShowExceptions
end

#
# Create and configure a toto instance
#
toto = Toto::Server.new do
  #
  # Add your settings here
  # set [:setting], [value]
  # 
    set :author,    "Dylan Lederle-Ensign"                    # blog author
    set :title,     "Dylan Lederle-Ensign"                     # site title
    set :url,       "http://dlederle.com/"
    set :root,      "index"                                   # page to load on /
    set :markdown, :smart              
  # use markdown + smart-mode
    set :disqus,    "dlederlecom"                                     # disqus id, or false
    set :summary,   :max => 150, :delim => /~\n/                # length of article summary and delimiter
    set :ext,       'txt'                                     # file extension for articles
    set :cache,      28800                                    # cache duration, in seconds
    set :date,      lambda {|now| now.strftime("%B #{now.day.ordinal} %Y")}
end

# Redirect www.blog.dlederle.com to blog.dlederle.com
#gem 'rack-rewrite', '~> 1.1.0'
#require 'rack-rewrite'
#if ENV['RACK_ENV'] == 'production'
#  use Rack::Rewrite do
#    r301 %r{.*}, 'http://blog.dlederle.com$&', :if => Proc.new {|rack_env|
#    rack_env['SERVER_NAME'] != 'blog.dlederle.com'
#  }
#  end
#end

run toto
