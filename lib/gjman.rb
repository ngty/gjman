require 'gjman/file_system'
require 'gjman/jruby'
require 'gjman/rjb'

module Gjman

  ROOT = File.join(File.expand_path(File.dirname(__FILE__)))
  JAVA_LIBS = []
  JAVA_MODE =  RUBY_PLATFORM =~ /java/i ? :JRuby : (
    begin
      require 'rjb'
      :Rjb
    rescue LoadError
      :Shell
    end
  )

  class << self

    def root(*args)
      args.size == 0 ? ROOT : File.join(ROOT, *args)
    end

    def ext(*args)
      root(*['ext', args].flatten)
    end
  end

end
