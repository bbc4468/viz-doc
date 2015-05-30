require File.expand_path("../lib/viz_doc/version", __FILE__)


Gem::Specification.new do |s|
  s.name = "viz_doc"
  s.summary = "Visual Documentation for your code."
  s.description = ""
  s.authors = [ "saurabh@tinyowl.co.in", "chaitanya.koparkar@tinyowl.co.in", "sunil.kumar@tinyowl.co.in"]

  s.files = `git ls-files`.split("n")
  s.executables = `git ls-files`.split("n").map{|f| f =~ /^bin/(.*)/ ? $1 : nil}.compact
  s.require_path = 'lib'

  s.version = VizDoc::VERSION
end
