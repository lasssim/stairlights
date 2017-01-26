require_relative "loxone/connection"
require_relative "loxone/state"
require_relative "loxone/control"
require_relative "loxone/event"
require_relative "loxone/message_handler"

module Loxone
  module_function

  def configure(hash={}, &block)
    @config = Confstruct::Configuration.new(hash, &block)
  end

  def config
    @config || configure
  end


end
