require_relative 'printer/base'

#if ENV["APP_ENV"] == "development"
  require_relative 'printer/sdl'
#end

module Printer

end
