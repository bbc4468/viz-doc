module VizDoc
  class CallStackLogger

    def initialize(allowed_classes)
      @allowed_classes = allowed_classes
      @logs = []
    end

    def reset
      @logs = []
      disable
      enable
    end

    def enable
      VizDoc::SetProc.enable(self)
    end

    def disable
      VizDoc::SetProc.disable
    end

    def log(log_data)
      @logs << OpenStruct.new(log_data)
    end

    def stack
      parse_logs([], @logs)
    end

    def allowed?(klass, method, event)
      return false if !@allowed_classes.include?(klass)
      [ 'call', 'return' ].include?(event)
    end

    # #####################
    # Private Methods
    # #####################
    private

    def parse_logs(calls, logs_data)
      return calls if logs_data.empty?

      log_data = logs_data.first


      if log_data.event == 'call'
        call = {
          id: rand(6 ** 6),
          method_name: log_data.method_name,
          class_name: log_data.class_name,
          calls: [],
          params: log_data.params,
          return_value: nil
        }
        calls.push call
      elsif log_data.event == 'return'
        call = calls.pop
        call[:return_value] = log_data.params

        previous_call = calls.pop
        if previous_call.nil?
          calls.push call
        else
          previous_call[:calls].push(call)
          calls.push previous_call
        end
      end
      parse_logs(calls, logs_data.drop(1))
    end
  end
end
