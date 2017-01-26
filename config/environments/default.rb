path_to_config = File.expand_path("../../settings.yml", __FILE__)
config_from_yml = YAML.load_file(path_to_config)[ENV['APP_ENV'] || "development"]

logger = Logger.new(STDOUT)

Loxone.configure(config_from_yml.merge(logger: logger))
