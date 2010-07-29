require 'gjman/file_system'

module Gjman

  ROOT = File.join(File.expand_path(File.dirname(__FILE__)))
  JPROCESSOR = :Shell
#    case RUBY_PLATFORM
#    when /java/i then :Jruby
#    else (require 'rjb' ; :Rjb) rescue :Shell
#    end

  class << self
    def root(*args)
      args.size == 0 ? ROOT : File.join(ROOT, *args)
    end
  end

end
