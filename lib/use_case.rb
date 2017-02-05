require_relative 'use_case/light_stairs'
require_relative 'use_case/find_uuid'

module UseCase
  module_function

  def configure(hash={}, &block)
    @config = Confstruct::Configuration.new(hash, &block)
  end

  def config
    @config || configure
  end


end
