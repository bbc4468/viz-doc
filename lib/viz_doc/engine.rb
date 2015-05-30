require "viz_doc/log"
require "viz_doc/set_proc"

# require_relative '../app/controllers/viz_doc/application_controller'
# require_relative '../app/controllers/viz_doc/log_controller'



module VizDoc
  class Engine < ::Rails::Engine
    isolate_namespace VizDoc

    if config.paths["config/routes"].present?
      config.paths["config/routes"].concat Dir[root.join("config/routes/*.rb")]
    end
  end

  autoload :ApplicationController, File.expand_path('../../../app/controllers/viz_doc/application_controller', __FILE__)
  autoload :LogController, File.expand_path('../../../app/controllers/viz_doc/log_controller', __FILE__)
end
