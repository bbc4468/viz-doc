module VizDoc
  class << self
    def enable
      set_trace_func proc { |event, file, line, method, binding, classname|
        begin
          if ['call', 'return'].include?(event) and VizDoc::Logger.classes.include?(classname.name)

            VizDoc::Logger.bindings_map[classname.to_s] = (classname.methods(false) + classname.instance_methods(false) - ActiveRecord::Base.methods + VizDoc::Logger.active_record_public_functions).reject { |x| x.to_s =~ /(after|before|autosave|validate|_one|_run|middleware)_/ or x.to_s =~ /\A_.*/ or x.to_s =~ /_path\Z/}

            vars = binding.local_variables
            params = {}
            vars.each do |var|
              params[var] = binding.local_variable_get(var)
            end

            allowed_bindings = VizDoc::Logger.bindings_map[classname.to_s]

            if allowed_bindings.include?(method)
              if classname.to_s == "ActiveRecord::Querying" and method.to_s == "find_by_sql"
                params = {}
                params[:sql] = binding.local_variable_get(:sql).to_sql
                classname = binding.local_variable_get(:sql).instance_variable_get(:@engine)
              end

              VizDoc::Logger.logger.info(sprintf "%8s %10s %8s %s", event, method, classname, params)
            else
              # VizDoc::Logger.logger.info("not found : #{method}")
            end
          end
        rescue Exception => e
          # VizDoc::Logger.logger.error(sprintf "%s %s %s", e.message, event, method)
        end
      }

      ActionController::Base.send(:include, VizDoc::ApplicationController)
    end

    def disable
      set_trace_func nil
    end
  end
end
