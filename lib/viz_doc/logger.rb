module VizDoc
class Logger

  @logger = Rails.logger
  @logger.level = Logger::INFO
  @logger.info "VizDoc Logger Initialized!"

  @bindings_map = {}
  @active_record_public_functions = [:find_by_sql]

  files = Dir["app/**/*.rb"] + Dir["engines/*/app/**/*.rb"]
  files = files.map {|f| f.gsub(/engines\/[_a-zA-Z]*\/app\/[a-zA-Z]*\//,"")}
  files = files.map {|f| f.gsub(/app\/[a-zA-Z]*\//,"")}
  files = files.map {|f| f.gsub(/\.rb/,"")}

  @classes = files.reduce([]) do |acc, f|
    parts = f.split('/')
    if parts.size > 1
      ## inside a module. join with ::
      x = parts.map do |part|
        part.split('_').map{|o| o.capitalize}.join
      end
      acc << x.join('::')
    else
      acc << parts.first.split('_').map{|o| o.capitalize}.join
    end
  end

  @classes.push("ActiveRecord::Querying")
  @classes.delete("LogController")

  class << self
    attr_accessor :logger, :bindings_map, :active_record_public_functions, :classes

    def get_logs(filename)
      lines = File.readlines(filename)
      parse_logs([], lines.drop(1))
    end

    def parse_logs(calls, lines)
      return calls if lines.empty?

      line = lines.first.strip
      x = line.split(' ')

      current = x[0]

      if current == "call"
        call = {}
        call["id"] = rand(6 ** 6)
        call["method_name"] = x[1]
        call["class_name"] = x[2]
        call["calls"] = []
        call["params"] = x[3..-1].join
        calls.push call
      elsif current == "return"
        i = calls.pop
        i["return_value"] = x[3..-1].join
        j = calls.pop
        if j.nil?
          calls.push i
        else
          j["calls"].push(i)
          calls.push j
        end
      end
      parse_logs(calls, lines.drop(1))
    end
  end
end
