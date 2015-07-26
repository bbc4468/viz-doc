require './calculator'
require './../viz-doc/lib/viz_doc'

profiler = VizDoc::CallStackProfiler.new("./.yardoc")
profiler.profile


