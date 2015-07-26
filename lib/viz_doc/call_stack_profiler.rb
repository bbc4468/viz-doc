module VizDoc
  class CallStackProfiler

    def initialize(yardoc_path)
      YARD::Registry.clear
      YARD::Registry.load!(yardoc_path)

      classes = YARD::Registry.all(:class).map { |x| eval x.name.to_s }

      @logger = VizDoc::CallStackLogger.new(classes)
    end

    def profile
      YARD::Registry.all(:method).each do |object|
        call_stacks = []
        object.tags(:example).each do |example|
          @logger.reset
          eval example.text
          call_stacks << OpenStruct.new(example: example, stack: @logger.stack)
        end
        object.call_stacks = call_stacks
      end
      @logger.disable
      YARD::Registry.save
    end

  end
end
