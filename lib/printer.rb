require_relative 'printer/base'

if ENV["APP_ENV"] == "development"
  require_relative 'printer/sdl'
end

require_relative 'printer/tcp'

module Printer

end
