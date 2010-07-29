require 'gjman/file_system'
require 'gjman/jruby'
require 'gjman/rjb'

module Gjman

  ROOT = File.join(File.expand_path(File.dirname(__FILE__)))
  JAVA_LIBS = []
  JAVA_MODE = case RUBY_PLATFORM
    when /java/i then :JRuby
    else (require 'rjb' ; :Rjb) rescue :Shell
    end

  class << self

    def root(*args)
      args.size == 0 ? ROOT : File.join(ROOT, *args)
    end

    def ext(*args)
      root(*['ext', args].flatten)
    end
  end

end
