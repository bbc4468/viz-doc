#require 'rails'
require 'yard'
require 'byebug'
require 'json'
#require 'viz_doc/engine'
#require 'viz_doc/module_manager'
require_relative 'viz_doc/set_proc'
require_relative 'viz_doc/call_stack_logger'
require_relative 'viz_doc/call_stack_profiler'
require_relative 'viz_doc/tasks'


#autoload :ApplicationController, File.expand_path('../../../app/controllers/viz_doc/application_controller', __FILE__)
#autoload :LogController, File.expand_path('../../../app/controllers/viz_doc/log_controller', __FILE__)

YARD::Templates::Engine.register_template_path File.dirname(__FILE__) + '/templates'

module VizDoc
end
