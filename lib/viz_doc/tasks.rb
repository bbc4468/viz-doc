module VizDoc
  class Tasks
    include Rake::DSL if defined? Rake::DSL

    def install_tasks
      namespace :vizdoc do

        desc 'clean up'
        task :cleanup do
          require 'fileutils'
          FileUtils.rm_rf("#{Dir.pwd}/.yardoc")
          FileUtils.rm_rf("#{Dir.pwd}/doc")
        end


        desc 'create yardoc objects'
        task :create_objects do |t, args|
          yard = YARD::CLI::Yardoc.new
          yard.generate = false
          yard.files = [ ENV['FILES'] ]
          yard.run
        end

        desc 'read yardoc objects and profile all methods'
        task :profile_objects do
          profiler = VizDoc::CallStackProfiler.new("#{Dir.pwd}/.yardoc")
          profiler.profile
        end

        desc 'read yardoc objects and generate doc'
        task :generate_doc do
          yard = YARD::CLI::Yardoc.new
          yard.use_cache = true
          yard.save_yardoc = false
          yard.files = [ ENV['FILES'] ]
          yard.run
        end


        desc 'generate vizdoc'
        task :generate do
          Rake::Task['vizdoc:cleanup'].invoke
          Rake::Task['vizdoc:create_objects'].invoke
          Rake::Task['vizdoc:profile_objects'].invoke
          Rake::Task['vizdoc:generate_doc'].invoke
        end
      end
    end
  end
end

VizDoc::Tasks.new.install_tasks
