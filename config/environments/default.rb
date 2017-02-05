path_to_config = File.expand_path("../../settings.yml", __FILE__)
config_from_yml = YAML.load_file(path_to_config)[ENV['APP_ENV'] || "development"]

logger = Logger.new(STDOUT)

Loxone.configure(config_from_yml["loxone"]) do
  logger logger
end


UseCase.configure(config_from_yml) do 
  logger        logger        
  canvas_class  Canvas.const_get(config_from_yml["canvas_class"])
  printer_class Printer.const_get(config_from_yml["printer_class"])
end 


