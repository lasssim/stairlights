require_relative 'use_case/light_stairs'
require_relative 'use_case/find_uuid'

module UseCase
  module_function

  def configure(&block)
    @config = Confstruct::Configuration.new(&block)
  end

  def config
    @config || configure
  end


end
