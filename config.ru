require "bundler/setup"

require "rack"
require "yard"

# YARD exposes a global `log`, yuck
log.level = Logger::DEBUG

# Global state lololololol
YARD::Server::RackAdapter.setup

# We need to tell YARD what to serve
#
# A little Sinatra app which dynamically browses gems and ruby versions would
# be nice eventually. Perhaps even a way to publish a project directory with a
# Gemfile.lock to expose the project docs and with its bundled gems would be
# cool, too.
libraries = {}

Gem.source_index.find_name('').each do |spec|
  libraries[spec.name] ||= []
  libraries[spec.name] |= [YARD::Server::LibraryVersion.new(spec.name, spec.version.to_s, nil, :gem)]
end

run YARD::Server::RackAdapter.new(libraries)
