module Gjman

  ROOT = File.join(File.expand_path(File.dirname(__FILE__)))

  class << self
    def root(*args)
      args.size == 0 ? ROOT : File.join(ROOT, *args)
    end
  end

end

require 'gjman/file_system'
require 'gjman/pdf'
