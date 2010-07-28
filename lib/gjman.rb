module Gjman

  ROOT = File.join(File.expand_path(File.dirname(__FILE__)))

  DEFAULTS = {
    :verbose => false
  }

  class << self

    attr_accessor *DEFAULTS.keys

    def root(*args)
      args.size == 0 ? ROOT : File.join(ROOT, *args)
    end

    def configure(args = {}, &block)
      args.each{|name, val| send(:"#{name}=", val) }
      block.call(self) if block_given?
    end

  end

  configure(DEFAULTS)

end

require 'gjman/file_system'
require 'gjman/pdf'
