module VizDoc
  class ModuleManager
    attr_reader :classes

    def initialize(wodule)
      @bindings_map = {}
      @wodule = wodule
      get_classes
    end

    def binding_allowed?(klass, method)
      return false if !@classes.include?(klass)
      return false if !bindings_map(klass).include?(method)
      true
    end

    private

    def get_classes
      @classes = @wodule.constants.select {|c| Class === @wodule.const_get(c)}.map { |c| eval "#{@wodule}::#{c}" }
      #@classes += ["ActiveRecord::Querying"]
    end

    def bindings_map(klass)
      @bindings_map[klass] = _bindings_map(klass) if @bindings_map[klass].nil?
      @bindings_map[klass]
    end

    def _bindings_map(klass)
      whitelist = [] #[:find_by_sql]
      blacklist = [] #ActiveRecord::Base.methods

      class_functions = klass.methods(false) +
                        klass.instance_methods(false) -
                        blacklist +
                        whitelist

      class_functions.reject do |x|
        x.to_s =~ /(after|before|autosave|validate|_one|_run|middleware)_/ or
        x.to_s =~ /\A_.*/ or
        x.to_s =~ /_path\Z/
      end
    end
  end
end
