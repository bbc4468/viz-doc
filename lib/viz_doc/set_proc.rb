module VizDoc
  class SetProc
    class << self
      def enable(logger)
        set_trace_func proc { |event, file, line, method, binding, klass|

          if logger.allowed?(klass, method.to_sym, event)

            params = {}
            # if klass.to_s == 'ActiveRecord::Querying' and method.to_s == 'find_by_sql'
            #   params[:sql] = binding.local_variable_get(:sql).to_sql
            #   klass = binding.local_variable_get(:sql).instance_variable_get(:@engine)
            # else

            binding.local_variables.each do |var|
              params[var] = binding.local_variable_get(var)
            end
            #end
            printf "%8s %10s %8s %s", event, method, klass, params
            logger.log(event:event, method: method, klass: klass, params: params)
          end
        }
      end

      def disable
        set_trace_func nil
      end
    end
  end
end
