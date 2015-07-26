module VizDoc
  class Engine < ::Rails::Engine
    isolate_namespace VizDoc

    if config.paths["config/routes"].present?
      config.paths["config/routes"].concat Dir[root.join("config/routes/*.rb")]
    end
  end
end
