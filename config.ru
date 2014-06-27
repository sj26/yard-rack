require "bundler/setup"

require "rack"
require "yard"

log.level = Logger::DEBUG

YARD::Server::RackAdapter.setup

libraries = {}

Gem.source_index.find_name('').each do |spec|
  libraries[spec.name] ||= []
  libraries[spec.name] |= [YARD::Server::LibraryVersion.new(spec.name, spec.version.to_s, nil, :gem)]
end

run YARD::Server::RackAdapter.new(libraries)
