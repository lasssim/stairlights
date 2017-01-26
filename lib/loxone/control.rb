module Loxone
  class Control
    attr_reader :name, :type, :uuid
    def initialize(control_hash)
      @name = control_hash.fetch("name")
      @type = control_hash.fetch("type")
      @uuid = control_hash.fetch("uuidAction")
    end

    def self.for(uuid:, http_client:)
      @controls ||= http_client.get("/data/LoxAPP3.json").body["controls"]
      control_hash = @controls[uuid]
      raise NotFound unless control_hash
      new(control_hash)
    end

    def inspect
      [
        "+-- Control ------------",
        "| Name: #{name}",
        "| Type: #{type}",
        "| UUID: #{uuid}",
        "+-----------------------"
      ].join("\n")
    end

    class NotFound < StandardError
    end

  end
end

