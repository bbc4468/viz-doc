$:.push File.expand_path("../lib", __FILE__)

require File.expand_path("../lib/viz_doc/version", __FILE__)


Gem::Specification.new do |s|
  s.name = "viz_doc"
  s.summary = "Visual Documentation for your code."
  s.description = ""
  s.authors = [ "saurabh@tinyowl.co.in", "chaitanya.koparkar@tinyowl.co.in", "sunil.kumar@tinyowl.co.in"]


  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  # s.files         = `git ls-files`.split($/).reject{ |f| f =~ /^examples/ }
  # s.executables   = s.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  # s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  # s.require_paths  = ['lib']

  s.version = VizDoc::VERSION
end
