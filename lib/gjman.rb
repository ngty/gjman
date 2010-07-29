require 'gjman/file_system'

module Gjman

  ROOT = File.join(File.expand_path(File.dirname(__FILE__)))
  JARS, JMODE = [],
    case RUBY_PLATFORM
    when /java/i then :JRuby
    else (require 'rjb' ; :Rjb) rescue :Shell
    end

  class << self

    def root(*args)
      args.size == 0 ? ROOT : File.join(ROOT, *args)
    end

    def rjb_load
      Rjb::load(JARS.join(':')) unless @rjb_loaded
      @rjb_loaded = true
    end

  end

end
